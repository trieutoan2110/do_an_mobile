import 'package:do_an_mobile/providers/home_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/home/product_featured_widget.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.categoryParent, required this.categoryTitle});

  final String categoryParent;
  final String categoryTitle;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  late HomeProvider _provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = Provider.of<HomeProvider>(context, listen: false);
    _provider.resetListProductInCart();
    _provider.getProductFromCategory(widget.categoryParent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryTitle)),
      body: listProduct(),
    );
  }

  Widget listProduct() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return homeProvider.listProductInCategory.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeProvider.listProductInCategory.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final product = homeProvider.listProductInCategory[index];
          String productID = product.id;
          String imageUrl = product.images[0];
          int price = product.minPrice;
          int discount = product.discountPercent;
          String title = product.title;
          int buyed = product.buyed;
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
}
