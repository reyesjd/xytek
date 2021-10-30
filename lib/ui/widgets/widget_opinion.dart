import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WidgetOpinion extends StatelessWidget {
  final String name;
  final String comment;
  final double rating;

  WidgetOpinion(
      {required this.name, required this.comment, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color.fromRGBO(228, 228, 228, 1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(7),
                child: Text(name,
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(7),
                child: RatingBar(
                  ignoreGestures: true,
                  updateOnDrag: false,
                  itemCount: 5,
                  allowHalfRating: false,
                  initialRating: rating,
                  onRatingUpdate: (double value) {},
                  ratingWidget: RatingWidget(
                      full: Icon(Icons.star, color: Colors.amber),
                      half: Icon(
                        Icons.star_border,
                        color: Colors.white,
                      ),
                      empty: Icon(Icons.star_border, color: Colors.amber)),
                ),
              )),
          Container(
            margin: EdgeInsets.all(7),
            child: Text(
              comment,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
