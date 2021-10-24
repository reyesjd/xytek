import 'package:flutter/material.dart';

class WidgetRoundedImage extends StatelessWidget {
  final String image;
  final Key keyImage;

  WidgetRoundedImage({required this.image, this.keyImage = const Key("")});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 6.0,
        ),
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
      ),
    );
  }
}
