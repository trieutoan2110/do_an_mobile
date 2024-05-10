import 'package:do_an_mobile/models/home_model/product_category_model.dart';
import 'package:do_an_mobile/models/home_model/product_model.dart';
import 'package:do_an_mobile/providers/checkout_provider.dart';
import 'package:do_an_mobile/providers/home_provider.dart';
import 'package:do_an_mobile/views/screen/auth_screen/login_view.dart';
import 'package:do_an_mobile/views/screen/main_screen/category_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/product_detail_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/search_screen.dart';
import 'package:do_an_mobile/views/widget/home/product_best_rate_widget.dart';
import 'package:do_an_mobile/views/widget/home/product_bestseller_widget.dart';
import 'package:do_an_mobile/views/widget/home/product_category_widget.dart';
import 'package:do_an_mobile/views/widget/home/product_featured_widget.dart';
import 'package:do_an_mobile/views/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data_sources/constants.dart';
import '../../../providers/AuthProvider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeProvider homeProvider;
  AuthProvider? authProvider;
  late CheckOutProvider _checkOutProvider;
  // CartProvider? cartProvider;
  ProductModel? productFeatureds;
  ProductModel? productBestSellers;
  ProductModel? productBestRates;
  ProductCategoryModel? productCategoryModel;

  @override
  void initState() {
    super.initState();
    _checkOutProvider = Provider.of<CheckOutProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider!.getUserInfor();
    authProvider!.checkLoginStatus();
    getDataHome();
  }

  void getDataHome() {
    homeProvider.getAllCategory();
    homeProvider.getAllProductBestSeller();
    homeProvider.getAllProductBestRate();
    homeProvider.getAllProductFeatured();
    _checkOutProvider.getListDiscount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      // drawer: Drawer(),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          titleOfProducts(StringConstant.product_category_title),
          listProductCategory(),
          titleOfProducts(StringConstant.product_best_sellers_title),
          listProductBestSeller(),
          titleOfProducts(StringConstant.product_best_rates_title),
          listProductBestRate(),
          titleOfProducts(StringConstant.product_featureds_title),
          const SizedBox(height: 10),
          listProductFeatured()
        ],
      ),
    );
  }

  PreferredSizeWidget customAppBar() {
    return AppBar(
      shadowColor: Colors.grey,
      title: const Text(
        StringConstant.home_title,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchProductScreen(listCategory: homeProvider.listProductCategory),));
          },
          icon: const Icon(Icons.search, size: 35),
        ),
      ],
    );
  }

  Widget listProductCategory() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return SizedBox(
        width: null,
        height: 150,
        child: homeProvider.listProductCategory.isEmpty
            ? const Center(child: CircularProgressIndicator())
            :  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeProvider.listProductCategory.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final productCategory =
                      homeProvider.listProductCategory[index];
                  String imageUrl = productCategory.image;
                  String categoryName = productCategory.title;
                  String id = productCategory.id;
                  return InkWell(
                    onTap: () {
                      _clickCategory(id, productCategory.title);
                    },
                    child: ProductCategoryWidget(
                        imageUrl: imageUrl, categoryName: categoryName),
                  );
                },
              ),
      );
    });
  }

  Widget listProductBestSeller() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return homeProvider.listProductBestSeller.isEmpty
          ? const LoadingWidget()
          : SizedBox(
              width: null,
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeProvider.listProductBestSeller.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final productBestSeller =
                      homeProvider.listProductBestSeller[index];
                  String productID = productBestSeller.id;
                  String imageUrl = productBestSeller.images[0];
                  int discount = productBestSeller.discountPercent;
                  int price = productBestSeller.minPrice;
                  int stock = 0;
                  int quantity = 0;
                  for (Group newGroup in productBestSeller.newGroup) {
                    stock += newGroup.stock;
                    quantity += newGroup.quantity;
                  }
                  return InkWell(
                      onTap: () {
                        _clickDetailProduct(productID);
                      },
                      child: ProductBestSellerWidget(
                          imageUrl: imageUrl,
                          discount: '-$discount%',
                          price: '\$$price',
                          stock: stock,
                          quantity: quantity));
                },
              ),
            );
    });
  }

  Widget listProductFeatured() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return homeProvider.listProductFeatured.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeProvider.listProductFeatured.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final productFeatured = homeProvider.listProductFeatured[index];
                String productID = productFeatured.id;
                String imageUrl = productFeatured.images[0];
                int price = productFeatured.minPrice;
                int discount = productFeatured.discountPercent;
                String title = productFeatured.title;
                int buyed = productFeatured.buyed;
                return InkWell(
                  onTap: () {
                    _clickDetailProduct(productID);
                  },
                  child: ProductFeaturedWidget(
                    price: '\$$price',
                    imageUrl: imageUrl,
                    discount: '-$discount%',
                    description: title,
                    buyed: buyed,
                  ),
                );
              },
            );
    });
  }

  Widget listProductBestRate() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return homeProvider.listProductBestRate.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: null,
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeProvider.listProductBestRate.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final productBestRate =
                      homeProvider.listProductBestRate[index];
                  String productID = productBestRate.id;
                  String imageUrl = productBestRate.images[0];
                  int discount = productBestRate.discountPercent;
                  int price = productBestRate.minPrice;
                  double rate = productBestRate.rate;
                  return InkWell(
                    onTap: () {
                      _clickDetailProduct(productID);
                    },
                    child: ProductBestRateWidget(
                        imageUrl: imageUrl,
                        discount: '-$discount%',
                        price: '\$$price',
                        rate: rate),
                  );
                },
              ),
            );
    });
  }

  Widget titleOfProducts(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }

  void _clickDetailProduct(String productID) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool isLogin = false;
    // if (prefs.getBool(StringConstant.is_login) != null) {
    //   isLogin = prefs.getBool(StringConstant.is_login)!;
    // }
    bool isLogin = authProvider!.isLogin;
    await Future.delayed(const Duration(seconds: 0));
    if (context.mounted) {
      if (isLogin) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailView(
                      productID: productID),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const loginView()
            ));
      }
    }
  }

  void _clickCategory(String id, String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = false;
    if (prefs.getBool(StringConstant.is_login) != null) {
      isLogin = prefs.getBool(StringConstant.is_login)!;
    }
    await Future.delayed(const Duration(seconds: 0));
    if (context.mounted) {
      if (isLogin) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryView(categoryParent: id, categoryTitle: title),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const loginView()
            ));
      }
    }
  }
}
