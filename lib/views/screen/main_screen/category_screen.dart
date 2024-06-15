import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/presenters/home_presenter.dart';
import 'package:do_an_mobile/providers/home_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/product_detail_screen.dart';
import 'package:do_an_mobile/views/widget/empty_widget.dart';
import 'package:do_an_mobile/views/widget/loading_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../models/home_model/product_model.dart';
import '../../widget/home/product_featured_widget.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.categoryParent, required this.categoryTitle});

  final String categoryParent;
  final String categoryTitle;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> implements HomeViewContract{

  late HomePresenter _presenter;
  late HomeProvider _provider;
  CircleLoading? _loading;
  late List<NewProduct> listProductFilter = [];
  int? rate;
  int? priceLeft;
  int? priceRight;
  List<int> rating = [1,2,3,4,5];
  List<List<int>> priceRange = [[0, 100], [100, 200], [200, 500],[500, 1000], [1000, 1000000]];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = HomePresenter(this);
    _provider = Provider.of<HomeProvider>(context, listen: false);
    _loading = CircleLoading();
    if (_provider.isLoading) {
      _loading!.show(context);
    }

    _presenter.getProductFromCategory(widget.categoryParent);
    listProductFilter = _provider.listProductInCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
        actions: [
        Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: const Row(
                  children: [
                    Icon(Icons.filter_alt_outlined, color: Colors.red, size: 32,),
                    Text('Filter', style: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                    ),)
                  ],
                ),
              ),
            );
          }
        )
      ],),
      endDrawer: _buildDrawer(),
      body: listProduct(),
    );
  }

  @override
  void dispose() {
    _provider.setLoading(true);
    _loading!.hide();
    super.dispose();
  }

  Widget _buildDrawer() {
    return Drawer(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: ListView (
            children: [
              const Text(StringConstant.rating, style: TextStyle(
                  fontSize: 20
              ),),
              Wrap(
                spacing: 10,
                children: rating.map((rating) {
                  return _choiceChipRate(rating);
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(StringConstant.price, style: TextStyle(
                  fontSize: 20
              ),),
              Wrap(
                spacing: 10,
                children: priceRange.map((range) {
                  return _choiceChipPrice(range);
                }).toList(),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: () {
                  _setListFilter(rate, priceLeft, priceRight);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration (
                    color: Colors.red
                  ),
                  child: const Center (
                    child: Text('Apply'),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Widget _choiceChipRate(int rating) {
    return ChoiceChip(
        selectedColor: Colors.red.withOpacity(0.4),
        checkmarkColor: Colors.red,
        backgroundColor: Colors.grey.withOpacity(0.2),
        shape: const LinearBorder(),
        label: Text(rating == 5? '$rating Stars' : '$rating Stars & Up'),
        selected: rate == rating,
        onSelected: (value) {
          setState(() {
            rate = value? rating : null;
          });
        },
    );
  }

  Widget _choiceChipPrice(List<int> priceRange) {
    return ChoiceChip(
      selectedColor: Colors.red.withOpacity(0.4),
      checkmarkColor: Colors.red,
      backgroundColor: Colors.grey.withOpacity(0.2),
      shape: const LinearBorder(),
      label: Text(priceRange[0] == 1000 ? '> ${priceRange[0]}\$' : '${priceRange[0]}\$ - ${priceRange[1]}\$'),
      selected: priceLeft == priceRange[0] && priceRight == priceRange[1],
      onSelected: (value) {
        setState(() {
          priceLeft = value? priceRange[0] : null;
          priceRight = value ? priceRange[1] : null;
        });
      },
    );
  }

  Widget listProduct() {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      if (!_provider.isLoading) {
        _loading!.hide();
      }
      return listProductFilter.isEmpty
          ? const EmptyWidget()
          : GridView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: listProductFilter.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final product = listProductFilter[index];
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

  void _setListFilter(int? rate, int? priceLeft, int? priceRight) {
    List<NewProduct> results = [];
    List<NewProduct> results1 = [];
    if (rate == null) {
      results = _provider.listProductInCategory;
    } else {
      results = _provider.listProductInCategory
          .where((product) => product.rate >= rate)
          .toList();
    }

    if (priceLeft == null || priceRight == null) {
      results1 = results;
    } else {
      results1 = results
          .where((product) => product.minPrice >= priceLeft && product.minPrice < priceRight)
          .toList();
    }
    setState(() {
      listProductFilter = results1;
    });
  }

  @override
  void getProductInCategoryComplete(List<NewProduct> list) {
    _provider.resetListProductInCategory();
    _provider.setListProductInCategory(list);
    _loading!.hide();
  }

  @override
  void getProductInCategoryError(String msg) {
    AppShowToast.showToast(msg);
    _loading!.hide();
  }
}
