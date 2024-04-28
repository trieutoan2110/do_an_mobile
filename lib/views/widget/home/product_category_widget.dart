import 'package:flutter/material.dart';

class ProductCategoryWidget extends StatelessWidget {
  const ProductCategoryWidget({super.key, required this.imageUrl, required this.categoryName});
  final String imageUrl;
  final String categoryName;

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
          // height: 100,
            // width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 69, 40, 146), width: 1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            )
        ),
        Text(categoryName)
      ],
    );
  }
}
