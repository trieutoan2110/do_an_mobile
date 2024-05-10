import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/models/home_model/product_detail_model.dart';
import 'package:do_an_mobile/providers/cart_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/home_model/checkout_model.dart';

class BuyProductScreen extends StatefulWidget {
  const BuyProductScreen(
      {super.key,
      required this.listGroup,
      required this.imageUrl,
      required this.titleProduct, required this.productID});

  final String productID;
  final List<Group> listGroup;
  final String imageUrl;
  final String titleProduct;

  @override
  State<BuyProductScreen> createState() => _BuyProductScreenState();
}

class _BuyProductScreenState extends State<BuyProductScreen> {
  String? selectedOption;
  int price = 0;
  int newPrice = 0;
  int stock = 0;
  int quantity = 0;
  bool isSelected = false;
  bool haveQuantity = false;
  String? titleProduct;
  String? childTitle;

  List<CheckOutModel> listCheckOut = [];
  late CartProvider cartProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.listGroup.isNotEmpty) {
      price = widget.listGroup[0].price;
      newPrice = widget.listGroup[0].priceNew!;
      stock = widget.listGroup[0].stock;
    }
    cartProvider = Provider.of<CartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 150),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: Image.network(widget.imageUrl, height: 150, width: 150),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$$newPrice',
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
                Text('Kho: $stock')
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(thickness: 0.5, height: 10, color: Colors.grey),
                const Text(
                  'Type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                (widget.listGroup.isEmpty)
                    ? Text('Not Type')
                    : Wrap(
                        spacing: 10,
                        children: widget.listGroup.map((option) {
                          return ChoiceChip(
                            selectedColor: Colors.red.withOpacity(0.4),
                            checkmarkColor: Colors.red,
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            shape: const LinearBorder(),
                            label: Text(option.childTitle),
                            selected: selectedOption == option.childTitle,
                            onSelected: (selected) {
                              setState(() {
                                if (selectedOption == option.childTitle) {
                                  isSelected = false;
                                } else {
                                  isSelected = true;
                                }
                                selectedOption =
                                    selected ? option.childTitle : null;
                                price = option.price;
                                newPrice = option.priceNew!;
                                stock = option.stock;
                                childTitle = option.childTitle;
                              });
                            },
                          );
                        }).toList(),
                      ),
                const Divider(thickness: 0.5, height: 20, color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      StringConstant.quantity,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (quantity > 0) {
                                quantity -= 1;
                                haveQuantity = true;
                              }
                              if (quantity == 0) {
                                haveQuantity = false;
                              }
                            });
                          },
                          child: const Icon(Icons.remove_circle_outline),
                        ),
                        const SizedBox(width: 8.0),
                        Text('$quantity'),
                        const SizedBox(width: 8.0),
                        InkWell(
                          onTap: () {
                            setState(() {
                              // if (quantity > 0 && quantity <= stock) {
                              //   haveQuantity = true;
                              // }
                              if (quantity > stock - 1) {
                                AppShowToast.showToast(
                                    'Quantity exceeds stock');
                                quantity = stock;
                              } else {
                                quantity += 1;
                                haveQuantity = true;
                              }
                            });
                          },
                          child: const Icon(Icons.add_circle_outline),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
      bottomNavigationBar: bottomNavigationBar()
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      // height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              cartProvider.addProductToCart(widget.productID, childTitle!, quantity);
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.1)),
              child: Icon(Icons.add_shopping_cart,
                  color: (haveQuantity && isSelected)
                      ? AppColor.ColorMain
                      : Colors.grey.withOpacity(0.5), size: 30),
            ),
          ),
          InkWell(
            onTap: () {
              (haveQuantity && isSelected)
                  ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckOutView(
                        listCheckOut: [
                          CheckOutModel(
                              imageUrl: widget.imageUrl,
                              productID: widget.productID,
                              titleProduct: widget.titleProduct,
                              quantity: quantity,
                              price: newPrice, childTitle: childTitle!)
                        ],
                      )
                  )
              ) : {};
            },
            child:
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 3*2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (haveQuantity && isSelected)
                      ? AppColor.ColorMain
                      : Colors.black.withOpacity(0.1)),
              child: Center(
                  child: Text(
                    StringConstant.buy_button_title,
                    style: TextStyle(
                        color:
                        (haveQuantity && isSelected) ? Colors.white : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
