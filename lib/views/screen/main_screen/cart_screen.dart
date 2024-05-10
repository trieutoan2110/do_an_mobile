import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/providers/AuthProvider.dart';
import 'package:do_an_mobile/providers/cart_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/checkout_screen.dart';
import 'package:do_an_mobile/views/widget/cart/product_cart_widget.dart';
import 'package:do_an_mobile/views/widget/empty_widget.dart';
import 'package:do_an_mobile/views/widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../models/home_model/checkout_model.dart';


class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  AuthProvider? authProvider;
  late CartProvider cartProvider;
  late bool isChanged = false;
  late double totalPayment = 0;
  late List<CheckOutModel> listCheckOut = [];
  CircleLoading? _loading;

  @override
  void initState() {
    super.initState();
    _loading = CircleLoading();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    if (authProvider!.isLogin) {
      cartProvider.setAllProductCart();
      if (cartProvider.isLoading) {
        _loading!.show(context);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (isChanged) {
      // cartProvider.resetListProductCart();
    }
    cartProvider.resetTotalPayment();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.01),
      appBar: AppBar(
        title: const Text(StringConstant.cart_title),
        centerTitle: true,
      ),
      body: authProvider!.isLogin? listProductCart() : const EmptyWidget(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(StringConstant.total_payment),
                Text('\$${cartProvider.totalPayment}')
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (cartProvider.totalPayment == 0) {

                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CheckOutView(listCheckOut: listCheckOut)
                      )
                  );
                }
              });
            }, child: Container (
            margin: const EdgeInsets.only(left:5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration (
              color: AppColor.ColorMain,
            ),
            child: const Center (
              child: Text (StringConstant.place_order, style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              )),
            ),
          ),
          )
        ],
      ),
    );
  }

  Widget listProductCart() {
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      if (!cartProvider.isLoading) {
        _loading!.hide();
      }
      return cartProvider.listProductCart.isNotEmpty?
      ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: cartProvider.listProductCart.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final productCart = cartProvider.listProductCart[index];
          String productID = productCart.productId;
          String imageUrl = productCart.infoProduct.images[0];
          String title = productCart.infoProduct.title;
          String childTitle = productCart.childTitle;
          int price = productCart.infoProduct.productChild.price;
          int priceNew = productCart.infoProduct.productChild.priceNew;
          List<String> listProperty = [];
          // for (var property in productCart.infoProduct.properties) {
          //   listProperty.add(childTitle);
          // }
          listProperty.add(childTitle);
          CheckOutModel product = CheckOutModel(
              productID: productID,
              imageUrl: imageUrl,
              titleProduct: title,
              quantity: productCart.quantity,
              price: priceNew, childTitle: childTitle
          );
          return Slidable(
            endActionPane: ActionPane (
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.red.withOpacity(0.7),
                  label: 'Delete',
                  icon: Icons.delete_forever_outlined,
                  onPressed: (context) {
                    cartProvider.deleteProductFromCart(productID, childTitle);
                    setState(() {

                    });
                },)
              ],
            ),
            child: ProductCartWidget(
              imageUrl: imageUrl, title: title,
              listProperty: listProperty, price: price, newPrice: priceNew,
              counter: productCart.quantity,
              cartProvider: cartProvider,
              increaseCount: () {
                setState(() {
                  productCart.quantity++;
                  if (cartProvider.isSelected) {
                    totalPayment = 0;
                    cartProvider.setTotalPayment(priceNew, true);
                  }
                  product = CheckOutModel(
                      productID: productID,
                      imageUrl: imageUrl,
                      titleProduct: title,
                      quantity: productCart.quantity,
                      price: priceNew,
                      childTitle: childTitle
                  );
                  addProductInListCheckOut(product);
                  isChanged = true;
                });
              },
              reduceCount: () {
                setState(() {
                  if (productCart.quantity > 0) {
                    totalPayment = 0;
                    productCart.quantity--;
                    if (cartProvider.isSelected) {
                      cartProvider.setTotalPayment(priceNew, false);
                    }
                    product = CheckOutModel(
                        productID: productID,
                        imageUrl: imageUrl,
                        titleProduct: title,
                        quantity: productCart.quantity,
                        price: priceNew,
                        childTitle: childTitle
                    );
                    addProductInListCheckOut(product);
                    isChanged = true;
                  }
                  if (productCart.quantity == 0) {
                    AppShowToast.showAlert(
                        context,
                        'Alert',
                        'Do you want delete product from cart?',
                        'Cancel',
                        'OK', () {
                          productCart.quantity = 1;
                          cartProvider.setTotalPayment(priceNew, true);
                          Navigator.pop(context);
                          setState(() {});
                        }, () {
                          Navigator.pop(context);
                          setState(() {

                          });
                    });
                  }
                });
              },
              setState: () {
                setState(() {
                  addProductInListCheckOut(product);
                });
                }
            ),
          );
        },
      ) : const EmptyWidget();
    },);
  }

  void addProductInListCheckOut(CheckOutModel product) {
    if (cartProvider.isSelected) {
      if (listCheckOut.isNotEmpty) {
        listCheckOut.removeWhere((element) => element.productID == product.productID);
      }
      listCheckOut.add(product);
    } else {
      listCheckOut.removeWhere((element) => element.productID == product.productID);
    }
  }
}
