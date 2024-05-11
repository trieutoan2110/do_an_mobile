import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/providers/info_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/main_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/product_detail_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/rating_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInforWidget extends StatefulWidget {
  const ProductInforWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.childTitle,
      required this.quantity,
      required this.price,
      required this.isRate,
      required this.isCancel,
      required this.isBuyAgain,
      required this.productID, required this.index});

  final int index;
  final String productID;
  final String imageUrl;
  final String title;
  final String childTitle;
  final int quantity;
  final int price;
  final bool isRate;
  final bool isCancel;
  final bool isBuyAgain;

  @override
  State<ProductInforWidget> createState() => _ProductInforWidgetState();
}

class _ProductInforWidgetState extends State<ProductInforWidget> {
  InforProvider? _provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = Provider.of<InforProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.black.withOpacity(0.01),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                widget.imageUrl,
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.childTitle),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${widget.price}'),
                      Text('x${widget.quantity}')
                    ],
                  )
                ],
              ))
            ],
          ),
          Visibility(
            visible: widget.isRate,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(color: AppColor.ColorMain),
              child: InkWell(
                  onTap: () {
                    if (widget.isBuyAgain) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailView(
                                  productID: widget.productID)));
                    } else {
                      if (widget.isRate) {
                        if (widget.isCancel) {
                          AppShowToast.showAlert(context, 'Cancel Order',
                              'Do you want to cancel your order?', 'Yes', 'Cancel',
                                  () {
                            String orderID = _provider!.listOrderIDByProductToPay[widget.index];
                            _provider!.cancel(orderID);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainView()));
                                  },
                                  () {
                            Navigator.pop(context);
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RatingScreen(
                                    productInforWidget: ProductInforWidget(
                                        imageUrl: widget.imageUrl,
                                        title: widget.title,
                                        childTitle: widget.childTitle,
                                        quantity: widget.quantity,
                                        price: widget.price,
                                        isRate: false,
                                        isCancel: false,
                                        isBuyAgain: false,
                                        productID: widget.productID, index: widget.index),)));
                        }
                      }
                    }
                  },
                  child: Text(
                    widget.isCancel
                        ? StringConstant.cancelled
                        : (widget.isBuyAgain
                            ? 'Buy Again'
                            : StringConstant.rate),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
