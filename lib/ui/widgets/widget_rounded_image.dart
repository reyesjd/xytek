import 'package:flutter/material.dart';

class WidgetRoundedImage extends StatelessWidget {
  final String image;
  final Key keyImage;
  final bool small;

  WidgetRoundedImage(
      {required this.image, this.keyImage = const Key(""), this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: small ? 100 : 200,
      height: small ? 100 : 200,
      /*
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 6.0,
        ),
        shape: BoxShape.circle,
      ),
      */
      child: Image(
        image: NetworkImage(image),
        fit: BoxFit.contain,
        errorBuilder: (BuildContext context, Object exception, stackTrace) {
          return Icon(Icons.image_not_supported_outlined);
        },
      ),
    );
  }
}
