import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/providers/cart_provider.dart';
import 'package:flutter/material.dart';

class ProductCartWidget extends StatefulWidget {
    const ProductCartWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.listProperty,
    required this.price, required this.newPrice,
    required this.counter,
    required this.cartProvider, required this.increaseCount, required this.reduceCount, required this.setState
  });

  final String imageUrl;
  final String title;
  final List<String> listProperty;
  final int price;
  final int newPrice;
  final int counter;
  final CartProvider cartProvider;
  final VoidCallback setState;
  final VoidCallback increaseCount;
  final VoidCallback reduceCount;

  @override
  State<ProductCartWidget> createState() => _ProductCartWidgetState();
}

class _ProductCartWidgetState extends State<ProductCartWidget> {

  bool isSelected = false;
  double total = 0;
  int totalPayment = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      color: Colors.white,
        child: Row(
          children: [
            Checkbox(
                value: isSelected,
                onChanged: (value){
                  isSelected = !isSelected;
                  widget.cartProvider.setIsSelected(isSelected);
                  totalPayment = widget.newPrice * widget.counter;
                  widget.cartProvider.setTotalPayment(totalPayment, isSelected);
                  widget.setState();
                },
                activeColor: AppColor.ColorMain,
            ),
            Image.network(widget.imageUrl, width: 100,height: 100),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.title,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis),
                  DropdownButton(
                    value: widget.listProperty[0],
                    items: widget.listProperty
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('\$${widget.newPrice}', style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                      )),
                      const SizedBox(width: 10),
                      Text('\$${widget.price}', textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough
                          )),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      InkWell(
                        onTap: widget.reduceCount,
                        child: const Icon(Icons.remove_circle_outline),
                      ),
                      const SizedBox(width: 8.0),
                      Text('${widget.counter}'),
                      const SizedBox(width: 8.0),
                      InkWell(
                        onTap: widget.increaseCount,
                        child: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}

