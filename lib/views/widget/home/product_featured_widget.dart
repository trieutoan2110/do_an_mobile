import 'package:do_an_mobile/core/app_colors.dart';
import 'package:flutter/material.dart';

class ProductFeaturedWidget extends StatelessWidget {
  const ProductFeaturedWidget({
    super.key,
    required this.price,
    required this.imageUrl,
    required this.discount,
    required this.description,
    required this.buyed, required this.rate, required this.normalPrice
  }
  );
  final String imageUrl;
  final String discount;
  final String price;
  final String normalPrice;
  final String description;
  final int buyed;
  final double rate;

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
                maxLines: 2,
                style: const TextStyle (
                  fontSize: 13
                ),
              ),
              Row(
                children: [
                  Text(price,
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(normalPrice,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.star, color: AppColor.ColorMain, size: 15,),
                      Text('$rate/5', style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400
                      )),
                    ],),
                    Container(width: 1, height: 10, color: Colors.black38, margin: const EdgeInsets.symmetric(horizontal: 5),),
                    Text('$buyed sold',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400
                        ))
                  ],
                ),
              ),
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
