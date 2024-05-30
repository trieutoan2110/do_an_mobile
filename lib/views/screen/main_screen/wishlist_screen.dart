import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/presenters/favorite_presenter.dart';
import 'package:do_an_mobile/providers/favorite_product_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/product_detail_screen.dart';
import 'package:do_an_mobile/views/widget/empty_widget.dart';
import 'package:do_an_mobile/views/widget/loading_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/home_model/product_model.dart';
import '../../widget/home/product_featured_widget.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> implements FavoriteViewContract{
  
  FavoritePresenter? _presenter;
  FavoriteProvider? _provider;
  CircleLoading? _loading;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = FavoritePresenter(this);
    _loading = CircleLoading();
    _provider = Provider.of<FavoriteProvider>(context, listen: false);
    _loading!.show(context);
    _presenter!.getListFavoriteProduct();
  }

  @override
  void dispose() {
    _loading!.hide();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        centerTitle: true,
        title: const Text('Wishlist'),
      ),
      body: listProduct(),
    );
  }

  Widget listProduct() {
    return Consumer<FavoriteProvider>(builder: (context, provider, child) {
      return provider.listProduct.isEmpty
          ? const EmptyWidget()
          : GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.listProduct.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final product = provider.listProduct[index];
          String productID = product.id;
          String imageUrl = product.images[0];
          int price = product.minPrice;
          int discount = product.discountPercent;
          String title = product.title;
          int buyed = product.buyed;
          double rate = product.rate;
          int normalPrice = product.newGroup[0].price;
          return InkWell(
            onTap: () {
              _clickDetailProduct(productID);
            },
            onLongPress: () {
              AppShowToast.showAlert(context, StringConstant.delete,
                  StringConstant.alert_delete_product_from_wishlist, 'Yes', 'Cancel',
                      () {
                _presenter!.deleteProductFromWishList(productID);
                Navigator.pop(context);
                  }, () {
                Navigator.pop(context);
                  });
            },
            child: ProductFeaturedWidget(
              price: '\$$price',
              imageUrl: imageUrl,
              discount: '-$discount%',
              description: title,
              buyed: buyed,
              rate: rate, normalPrice: '\$$normalPrice',
            ),
          );
        },
      );
    });
  }

  void _clickDetailProduct(String productID) async {
    await Future.delayed(const Duration(seconds: 0));
    if (context.mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailView(
                    productID: productID),
          )
      );
    }
  }

  @override
  void getFavoriteListComplete(List<NewProduct> products) {
    _provider!.resetListProduct();
    _provider!.setListProduct(products);
    _loading!.hide();
  }

  @override
  void getFavoriteListError(String msg) {
    AppShowToast.showToast(msg);
    _loading!.hide();
  }

  @override
  void deleteProductComplete(String productID) {
    _provider!.deleteProduct(productID);
  }
}
