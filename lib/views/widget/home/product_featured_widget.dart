import 'package:flutter/material.dart';

class ProductFeaturedWidget extends StatelessWidget {
  const ProductFeaturedWidget({
    super.key,
    required this.price,
    required this.imageUrl,
    required this.discount,
    required this.description,
    required this.buyed
  }
  );
  final String imageUrl;
  final String discount;
  final String price;
  final String description;
  final int buyed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
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
              Text(description,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 2),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      ),
                    ),
                    Text('$buyed sold',
                        style: const TextStyle(
                            // backgroundColor: Colors.black,
                            // color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        ))
                  ],
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
