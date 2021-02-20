import 'dart:io';
import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BootcampPostScreen extends StatefulWidget {
  static const route = '/postBootcampScreen';

  @override
  _BootcampPostScreenState createState() => _BootcampPostScreenState();
}

class _BootcampPostScreenState extends State<BootcampPostScreen> {
  final _form = GlobalKey<FormState>();
  var _bootcamp = BootcampData(
    careers: '',
    photo: '',
    image: null,
    name: '',
    description: '',
    website: '',
    phone: '',
    email: '',
    address: '',
    lat: "36.1901",
    log: "43.9930",
  );

  var _isLoading = false;

  Future<void> _saveForm() async {
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    await Provider.of<BootCamp>(context, listen: false)
        .postBootcamp(_bootcamp, context);

    setState(() {
      _isLoading = false;
    });
  }

  //take picture and uploaded
  var _uploadImage;
  File _storedImage;

  Future<void> takePicture() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _storedImage = imageFile;
    });
  }

  Future _getUpload() async {
    try {
      final StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(DateTime.now().toString());
      final StorageUploadTask task = firebaseStorageRef.putFile(_storedImage);

      var downUrl = await (await task.onComplete).ref.getDownloadURL();
      var url = downUrl.toString();
      var urlConcat = (url + "jpg");
      print(urlConcat);
      print(_getUpload);

      setState(() {
        _uploadImage = urlConcat;
      });
    } catch (error) {
      showDialog(
          context: context,
          builder: (_) => Container(
                child: AlertDialog(
                  title: Text(
                    "Image Error!",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  content: Text(
                    'pleas select the image in then upload',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  actions: [
                    FlatButton(
                      child: Text('ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ));
    }
  }

//get the current location
  GoogleMapController mapController;
  LatLng markerLatLog;
  List<Marker> myMarker = [];
  String locationMessage = "";
  LatLng currentLocation;

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height / 3.5;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'), // if(_storedImage != null){
        //   _getUpload();
        //   print('getImage');
        // }
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          takePicture();
                        },
                        child: Container(
                            height: height,
                            width: width,
                            child: Card(
                                color: Colors.white,
                                elevation: 0,
                                child: _storedImage == null
                                    ? Image.asset('assets/images/addImage.png')
                                    : Image.file(
                                        _storedImage,
                                      )))),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, right: 15, left: 15, bottom: 25),
                      child: Column(
                        children: [
                          ActionChip(
                            avatar:
                                isSelected ? CircularProgressIndicator() : null,
                            label: Text(
                                '${isSelected ? 'Uploading...' : '   Upload   '}'),
                            labelStyle: TextStyle(color: Colors.white),
                            onPressed: () async {
                              setState(() {
                                isSelected = !isSelected;
                              });
                              await _getUpload();
                              isSelected = false;
                            },
                            backgroundColor: Colors.black54,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration:
                                  textFormField('phone Number', 'phone Number'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _bootcamp = BootcampData(
                                    careers: _bootcamp.careers,
                                    name: _bootcamp.name,
                                    address: _bootcamp.address,
                                    website: _bootcamp.website,
                                    email: _bootcamp.email,
                                    description: _bootcamp.description,
                                    phone: value,
                                    photo: _uploadImage,
                                    lat: markerLatLog.latitude,
                                    log: markerLatLog.longitude);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration:
                                  textFormField('description', 'description'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _bootcamp = BootcampData(
                                    careers: _bootcamp.careers,
                                    name: _bootcamp.name,
                                    address: _bootcamp.address,
                                    website: _bootcamp.website,
                                    email: _bootcamp.email,
                                    description: value,
                                    phone: _bootcamp.phone,
                                    photo: _uploadImage,
                                    lat: markerLatLog.latitude,
                                    log: markerLatLog.longitude);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textFormField('email', 'email'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _bootcamp = BootcampData(
                                    careers: _bootcamp.careers,
                                    name: _bootcamp.name,
                                    address: _bootcamp.address,
                                    website: _bootcamp.website,
                                    email: value,
                                    description: _bootcamp.description,
                                    phone: _bootcamp.phone,
                                    photo: _uploadImage,
                                    lat: markerLatLog.latitude,
                                    log: markerLatLog.longitude);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textFormField('website', 'website'),
                              keyboardType: TextInputType.url,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _bootcamp = BootcampData(
                                    careers: _bootcamp.careers,
                                    name: _bootcamp.name,
                                    address: _bootcamp.address,
                                    website: value,
                                    email: _bootcamp.email,
                                    description: _bootcamp.description,
                                    phone: _bootcamp.phone,
                                    photo: _uploadImage,
                                    lat: markerLatLog.latitude,
                                    log: markerLatLog.longitude);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textFormField('address', 'address'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _bootcamp = BootcampData(
                                    careers: _bootcamp.careers,
                                    name: _bootcamp.name,
                                    address: value,
                                    website: _bootcamp.website,
                                    email: _bootcamp.email,
                                    description: _bootcamp.description,
                                    phone: _bootcamp.phone,
                                    photo: _uploadImage,
                                    lat: markerLatLog.latitude,
                                    log: markerLatLog.longitude);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textFormField('name', 'name'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _bootcamp = BootcampData(
                                    careers: _bootcamp.careers,
                                    name: value,
                                    address: _bootcamp.address,
                                    website: _bootcamp.website,
                                    email: _bootcamp.email,
                                    description: _bootcamp.description,
                                    phone: _bootcamp.phone,
                                    photo: _uploadImage,
                                    lat: markerLatLog.latitude,
                                    log: markerLatLog.longitude);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textFormField('careers', 'careers'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _bootcamp = BootcampData(
                                    careers: value,
                                    name: _bootcamp.name,
                                    address: _bootcamp.address,
                                    website: _bootcamp.website,
                                    email: _bootcamp.email,
                                    description: _bootcamp.description,
                                    phone: _bootcamp.phone,
                                    photo: _uploadImage,
                                    lat: markerLatLog.latitude,
                                    log: markerLatLog.longitude);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        height: 300,
                        child: GoogleMap(
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>[
                            new Factory<OneSequenceGestureRecognizer>(
                              () => new EagerGestureRecognizer(),
                            ),
                          ].toSet(),
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(36.1901, 43.9930), zoom: 7.0),
                          markers: Set.from(myMarker),
                          onTap: (LatLng position) {
                            setState(() {
                              markerLatLog = position;
                              myMarker = [];
                              _bootcamp = BootcampData(
                                  careers: _bootcamp.careers,
                                  name: _bootcamp.name,
                                  address: _bootcamp.address,
                                  website: _bootcamp.website,
                                  email: _bootcamp.email,
                                  description: _bootcamp.description,
                                  phone: _bootcamp.phone,
                                  photo: _uploadImage,
                                  lat: markerLatLog.latitude,
                                  log: markerLatLog.longitude);
                              myMarker.add(
                                Marker(
                                  markerId: MarkerId(position.toString()),
                                  position: position,
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
