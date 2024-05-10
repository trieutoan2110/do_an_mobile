import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductBestRateWidget extends StatelessWidget {
  const ProductBestRateWidget({
    super.key,
    required this.imageUrl,
    required this.discount,
    required this.price,
    required this.rate
  });

  final String imageUrl;
  final String price;
  final String discount;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 180,
      height: 240,
      decoration: BoxDecoration (
          border: Border.all(
              color: Colors.black45, width: 0.8
          )
      ),
      child: Stack (
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(imageUrl,fit: BoxFit.cover),
              const SizedBox(height: 5),
              Text(price,
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 17
                ),
              ),
              RatingBar.builder(
                allowHalfRating: true,
                ignoreGestures: true,
                initialRating: rate,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 25,
                itemBuilder: (context, index) {
                  return const Icon(Icons.star, color: Colors.red, size: 25);
                },
                onRatingUpdate: (value) {

                },
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(discount,
                    style: const TextStyle(
                        backgroundColor: Colors.red,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    )),
                // const Icon(Icons.favorite, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
