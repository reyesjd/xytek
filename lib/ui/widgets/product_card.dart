import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final int price;
  final Function onPressed;

  final formatCurrency = NumberFormat.currency(
    decimalDigits: 0,
    symbol: '\$',
    customPattern: '\u00a4 ###,###',
  );

  ProductCard(
      {required this.name,
      required this.image,
      required this.price,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {onPressed()},
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Image(
                      height: 80,
                      fit: BoxFit.contain,
                      image: NetworkImage(
                        image,
                      ),
                      errorBuilder:
                          (BuildContext context, Object exception, stackTrace) {
                        return Icon(Icons.image_not_supported_outlined);
                      },
                    )),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        formatCurrency.format(price).replaceAll(',', '.'),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
