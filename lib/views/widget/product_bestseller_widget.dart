import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProductBestSellerWidget extends StatelessWidget {
  const ProductBestSellerWidget({
    super.key,
    required this.imageUrl,
    required this.discount,
    required this.price,
    required this.stock,
    required this.quantity
  });

  final String imageUrl;
  final String price;
  final String discount;
  final int stock;
  final int quantity;

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
              LinearPercentIndicator (
                backgroundColor: Colors.red.shade100,
                progressColor: Colors.red,
                lineHeight: 14,
                percent: stock/quantity,
                barRadius: const Radius.circular(7),
                center: Text('SOLD $stock',
                  style: const TextStyle (
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 12
                  ),
                ),
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
