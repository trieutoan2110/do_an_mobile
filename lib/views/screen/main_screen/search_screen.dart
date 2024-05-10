
import 'package:do_an_mobile/views/screen/main_screen/category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/home_model/product_category_model.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key, required this.listCategory});
  final List<ProductCategory> listCategory;
  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {

  List<ProductCategory> _listFoundProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listFoundProduct = widget.listCategory;
  }

  void _runFilter(String enterKeyword) {
    List<ProductCategory> results = [];
    if (enterKeyword.isEmpty) {
      results = widget.listCategory;
    } else {
      results = widget.listCategory
          .where((category) => category.title.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _listFoundProduct = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: const Text('Search Product'),
      ),
      body: Container (
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration (
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search)
                )
              ),
              const SizedBox(height: 10,),
              ListView.builder(
                itemCount: _listFoundProduct.length > 8 ? 8 : _listFoundProduct.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  List<ProductCategory> list = _listFoundProduct;
                  return _buildListViewItem(list[index]
                  );
              },)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListViewItem(ProductCategory category) {
    return InkWell(
      key: ValueKey(category.id),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryView(categoryParent: category.id, categoryTitle: category.title)));
      },
      child: ListTile(
        title: Text(category.title),
        leading: CircleAvatar (
          child: Image.network(category.image, fit: BoxFit.fill, width: 50, height: 50),
        ),
      ),
    );
  }
}
