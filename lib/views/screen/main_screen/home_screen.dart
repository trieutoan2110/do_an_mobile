import 'dart:convert';
import 'package:do_an_mobile/models/home_model/product_category_model.dart';
import 'package:do_an_mobile/models/home_model/product_model.dart';
import 'package:do_an_mobile/views/widget/product_best_rate_widget.dart';
import 'package:do_an_mobile/views/widget/product_bestseller_widget.dart';
import 'package:do_an_mobile/views/widget/product_category_widget.dart';
import 'package:do_an_mobile/views/widget/product_featured_widget.dart';
import 'package:flutter/material.dart';
// import 'package:html_unescape/html_unescape.dart';

import '../../../data_sources/constants.dart';
import '../../../data_sources/repositories/product_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ProductModel? productFeatureds;
  ProductModel? productBestSellers;
  ProductModel? productBestRates;
  ProductCategoryModel? productCategoryModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((_) {
      ProductReposityImpl.shared.getProductFeatured().then((value) {
        setState(() {
          productFeatureds = ProductModel.fromJson(jsonDecode(value));
        });
      });

      ProductReposityImpl.shared.getProductCategory().then((value) {
        setState(() {
          productCategoryModel =
              ProductCategoryModel.fromJson(jsonDecode(value));
        });
      });

      ProductReposityImpl.shared.getProductBestSeller().then((value) {
        setState(() {
          productBestSellers = ProductModel.fromJson(jsonDecode(value));
        });
      });

      ProductReposityImpl.shared.getProductBestRate().then((value) {
        setState(() {
          productBestRates = ProductModel.fromJson(jsonDecode(value));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: Drawer(),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const Text(StringConstant.product_category_title),
          ListProductCategory(),
          const Text(StringConstant.product_best_sellers_title),
          ListProductBestSeller(),
          const Text(StringConstant.product_best_rates_title),
          ListProductBestRate(),
          const Text(StringConstant.product_featureds_title),
          const SizedBox(height: 10),
          ListProductFeatured()
        ],
      ),
    );
  }

  PreferredSizeWidget customAppBar() {
    return AppBar (
      title: const Text(
        StringConstant.home_title,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, size: 35),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_outlined, size: 35),
        )
      ],
    );
  }

  Widget ListProductCategory() {
    return Container(
      width: null,
      height: 150,
      child: productCategoryModel == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productCategoryModel!.productCategorys.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final productCategory = productCategoryModel!.productCategorys;
                String imageUrl = productCategory[index].image;
                String categoryName = productCategory[index].title;
                return ProductCategoryWidget(
                    imageUrl: imageUrl, categoryName: categoryName);
              },
            ),
    );
  }

  Widget ListProductBestSeller() {
    return productBestSellers == null
        ? const Center(child: CircularProgressIndicator())
        : Container(
            width: null,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productBestSellers!.newProduct.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final productBestSeller = productBestSellers!.newProduct;
                String imageUrl = productBestSeller[index].images[0];
                int discount = productBestSeller[index].discountPercent;
                int price = productBestSeller[index].minPrice;
                int stock = 0;
                int quantity = 0;
                for (Group newGroup in productBestSeller[index].newGroup) {
                  stock += newGroup.stock;
                  quantity += newGroup.quantity;
                }
                return ProductBestSellerWidget(
                    imageUrl: imageUrl,
                    discount: '-$discount%',
                    price: 'đ$price.000',
                    stock: stock,
                    quantity: quantity);
              },
            ),
          );
  }

  Widget ListProductFeatured() {
    return productFeatureds == null
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productFeatureds!.newProduct.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final productFeatured = productFeatureds!.newProduct[index];
              String imageUrl = productFeatured.images[0];
              int price = productFeatured.minPrice;
              int discount = productFeatured.discountPercent;
              String title = productFeatured.title;
              return ProductFeaturedWidget(
                  price: 'đ$price.000',
                  imageUrl: imageUrl,
                  discount: '-$discount%',
                  description: title);
            },
          );
  }

  Widget ListProductBestRate() {
    return productBestRates == null
        ? const Center(child: CircularProgressIndicator())
        : Container(
      width: null,
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productBestRates!.newProduct.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final productBestRate = productBestRates!.newProduct[index];
          String imageUrl = productBestRate.images[0];
          int discount = productBestRate.discountPercent;
          int price = productBestRate.minPrice;
          double rate = productBestRate.rate;
          return ProductBestRateWidget (
              imageUrl: imageUrl,
              discount: '-$discount%',
              price: 'đ$price.000',
              rate: rate);
        },
      ),
    );
  }
}
