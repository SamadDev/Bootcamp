import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadMultipleImageDemo extends StatefulWidget {
  UploadMultipleImageDemoState createState() => UploadMultipleImageDemoState();
}

class UploadMultipleImageDemoState extends State<UploadMultipleImageDemo> {
  Map<String, String> _paths;
  String _extension;
  List<StorageUploadTask> _videos = <StorageUploadTask>[];

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    _videos.forEach((StorageUploadTask video) {
      final Widget tile = UploadTaskListTile(
        task: video,
        onDismissed: () => setState(() => _videos.remove(video)),
        onDownload: () => downloadFile(video.lastSnapshot.ref),
      );
      children.add(tile);
    });

    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              OutlineButton(
                onPressed: () => openFileExplorer(),
                child: new Text("Open file picker"),
              ),
              SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: ListView(
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openFileExplorer() async {
    try {
      _paths = await FilePicker.getMultiFilePath(
        type: FileType.video,
      );
      uploadToFirebase();
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
  }

  uploadToFirebase() {
    _paths.forEach((fileName, filePath) => {upload(fileName, filePath)});
  }

  upload(fileName, filePath) {
    _extension = fileName.toString().split('.').last;
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
      StorageMetadata(
        contentType: '$FileType.video/$_extension',
      ),
    );
    setState(() {
      _videos.add(uploadTask);
    });
  }

  Future<void> downloadFile(StorageReference ref) async {
    final String url = await ref.getDownloadURL();

    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp.jpg');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
    final String name = await ref.getName();
    final String path = await ref.getPath();
    print(
      'Success!\nDownloaded $name \nUrl: $url'
      '\npath: $path \nBytes Count :: $byteCount',
    );
  }
}

class UploadTaskListTile extends StatelessWidget {
  const UploadTaskListTile({this.task, this.onDismissed, this.onDownload});

  final StorageUploadTask task;
  final VoidCallback onDismissed;
  final VoidCallback onDownload;

  String get status {
    String result;
    if (task.isComplete) {
      if (task.isSuccessful) {
        result = 'Complete';
      } else if (task.isCanceled) {
        result = 'Canceled';
      } else {
        result = 'Failed ERROR: ${task.lastSnapshot.error}';
      }
    } else if (task.isInProgress) {
      result = 'Uploading';
    } else if (task.isPaused) {
      result = 'Paused';
    }
    return result;
  }

  String _bytesTransferred(StorageTaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalByteCount}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StorageTaskEvent>(
      stream: task.events,
      builder: (BuildContext context,
          AsyncSnapshot<StorageTaskEvent> asyncSnapshot) {
        Widget subtitle;
        if (asyncSnapshot.hasData) {
          final StorageTaskEvent event = asyncSnapshot.data;
          final StorageTaskSnapshot snapshot = event.snapshot;
          subtitle = Text('$status: ${_bytesTransferred(snapshot)} bytes sent');
        } else {
          subtitle = const Text('Starting...');
        }
        return Dismissible(
          key: Key(task.hashCode.toString()),
          onDismissed: (_) => onDismissed(),
          child: ListTile(
            title: Text('Upload Task #${task.hashCode}'),
            subtitle: subtitle,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Offstage(
                  offstage: !task.isInProgress,
                  child: IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () => task.pause(),
                  ),
                ),
                Offstage(
                  offstage: !task.isPaused,
                  child: IconButton(
                    icon: const Icon(Icons.file_upload),
                    onPressed: () => task.resume(),
                  ),
                ),
                Offstage(
                  offstage: task.isComplete,
                  child: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () => task.cancel(),
                  ),
                ),
                Offstage(
                  offstage: !(task.isComplete && task.isSuccessful),
                  child: IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: onDownload,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   File _video;
//   File _cameraVideo;
//
//   ImagePicker picker = ImagePicker();
//
//   VideoPlayerController _videoPlayerController;
//   VideoPlayerController _cameraVideoPlayerController;
//
//   // This funcion will helps you to pick a Video File
//   _pickVideo() async {
//     PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
//
//     _video = File(pickedFile.path);
//
//     _videoPlayerController = VideoPlayerController.file(_video)
//       ..initialize().then((_) {
//         setState(() {});
//         _videoPlayerController.play();
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: <Widget>[
//                 if (_video != null)
//                   _videoPlayerController.value.initialized
//                       ? AspectRatio(
//                           aspectRatio: _videoPlayerController.value.aspectRatio,
//                           child: VideoPlayer(_videoPlayerController),
//                         )
//                       : Container()
//                 else
//                   Text(
//                     "Click on Pick Video to select video",
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                 RaisedButton(
//                   onPressed: () {
//                     _pickVideo();
//                   },
//                   child: Text("Pick Video From Gallery"),
//                 ),
//                 if (_cameraVideo != null)
//                   _cameraVideoPlayerController.value.initialized
//                       ? AspectRatio(
//                           aspectRatio:
//                               _cameraVideoPlayerController.value.aspectRatio,
//                           child: VideoPlayer(_cameraVideoPlayerController),
//                         )
//                       : Container()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
