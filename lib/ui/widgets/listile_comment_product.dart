import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class WidgetCommentProduct extends StatelessWidget {
  WidgetCommentProduct(
      {Key? key,
      required this.linkImage,
      required this.name,
      required this.rating,
      required this.date,
      required this.comment})
      : super(key: key);

  late  String linkImage;
  late String name;
  late  double rating;
  late  String date;
  late  String comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: WidgetRoundedImage(
        image: linkImage,
        small: true,
      ),
      title: Text(name),
      subtitle: Container(
        margin: EdgeInsets.only(top: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar(
                  itemSize: 20,
                  ignoreGestures: true,
                  updateOnDrag: false,
                  itemCount: 5,
                  allowHalfRating: true,
                  initialRating: rating,
                  onRatingUpdate: (double value) {},
                  ratingWidget: RatingWidget(
                      full: Icon(Icons.star, color: Colors.amber),
                      half: Icon(Icons.star_half, color: Colors.amber),
                      empty: Icon(Icons.star_border, color: Colors.amber)),
                ),
                Text(date)
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                comment,
                maxLines: 3,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
