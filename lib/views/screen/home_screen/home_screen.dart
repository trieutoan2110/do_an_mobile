import 'dart:convert';

import 'package:do_an_mobile/managers/repositories/product_repository.dart';
import 'package:do_an_mobile/models/home_model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((_) {
      ProductReposityImpl.shared.getProductBestRate().then((value) {
        ProductModel productModel = ProductModel.fromJson(jsonDecode(value));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: const Text(
            'HOME',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton (

            onPressed: () {

            },
            icon: const Icon(Icons.search, size: 35),
          ),
          IconButton (
            onPressed: () {

            },
            icon: const Icon(Icons.shopping_cart_outlined, size: 35),
          )
        ],
      ),
      drawer: Drawer(),
      body: ListView (
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Text('Product Category'),
          ListProductCategory(),
          Text('Product best seller'),
          ListProductBestSeller(),
          Text('Product Featured'),
          ListProductFeatured()
        ],
      ),
    );
  }

  Widget ListProductCategory() {
    return Container(
      width: null,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProductCategory();
        },
      ),
    );
  }

  Widget ListProductBestSeller() {
    return Container(
      width: null,
      height:150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProductBestSeller();
        },
      ),
    );
  }

  Widget ListProductFeatured() {
    return Container(
      child: GridView.count(
        //childAspectRatio: 0.68,
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (int i = 0; i < 9; i++)
            ProductFeatured()
        ],
      )
    );
  }

  Widget ProductCategory() {
    return Container(
        margin: const EdgeInsets.all(5),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          border: Border.all(
              color: const Color.fromARGB(
                  255, 69, 40, 146),
              width: 1),
          borderRadius: BorderRadius.circular(50),
        )
    );
  }

  Widget ProductBestSeller() {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 150,
      width: 100,
      color: Colors.green,
    );
  }

  Widget ProductFeatured() {
    return Container(
      margin: const EdgeInsets.all(3),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
