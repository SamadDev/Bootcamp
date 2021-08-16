import 'package:bootcamps/Style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List imagesList = [
  'https://firebasestorage.googleapis.com/v0/b/bootcamp-cc44f.appspot.com/o/unnamed.jpg?alt=media&token=5a7cc276-0af1-464c-8efd-332cf324c055',
  'https://firebasestorage.googleapis.com/v0/b/bootcamp-cc44f.appspot.com/o/codeing-bootcamp-banner-1.png?alt=media&token=950d1e07-3848-4e3e-8e43-1e155c38b1bf',
  'https://firebasestorage.googleapis.com/v0/b/bootcamp-cc44f.appspot.com/o/2021-08-14%2008%3A20%3A31.512784?alt=media&token=af4ad7b1-a9e2-41e6-854c-6edc827b4748jpg',
];

class SpecialProduct extends StatefulWidget {
  @override
  _SpecialProductState createState() => _SpecialProductState();
}

class _SpecialProductState extends State<SpecialProduct> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(

            aspectRatio:1.9,
            viewportFraction:1,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
          ),
          items: imagesList
              .map(
                (image) => Container(
                  height: 150,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fill,
                    placeholder: (ctx, snap) =>
                        Image.asset('assets/images/imageloading.gif',fit: BoxFit.fitWidth,)
                  ),
                ),
              )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagesList.map((image) {
            int index = imagesList.indexOf(image);
            return Container(
              height: _currentIndex == index ? 15 : 12,
              width: _currentIndex == index ? 15 : 12,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _currentIndex == index ? AppTheme.green : AppTheme.black2,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
