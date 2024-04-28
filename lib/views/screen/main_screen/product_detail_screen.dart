import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/providers/home_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/buy_product_screen.dart';
import 'package:do_an_mobile/views/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../../../data_sources/constants.dart';
import '../../../models/home_model/product_detail_model.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key,
    required this.productID,
    required this.homeProvider
  });

  final String productID;

  final HomeProvider homeProvider;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {

  late List<Group> _listGroup = [];
  late String imageUrl;
  late String titleProduct;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getDataDetail() {
    widget.homeProvider.resetProductDetail();
    widget.homeProvider.getProductDetail(widget.productID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<HomeProvider>(builder: (context, value, child) {
            final productDetail = value.productDetail;
            return value.productDetail == null
                ? const LoadingWidget()
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: ImageSlideshow(
                            autoPlayInterval: 0,
                            isLoop: true,
                            children: [
                              for (var image in value.productDetail!.images)
                                Image.network(image)
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\$${productDetail!.minPrice}',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: AppColor.ColorMain,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '\$${productDetail.group[0].price}',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                productDetail.title,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              rating(productDetail.rate),
                              const SizedBox(height: 10),
                              const Text(StringConstant.description),
                              const SizedBox(height: 10),
                              // Text(parse(productDetail.description)
                              //     .documentElement!
                              //     .text)
                              HtmlWidget(
                                productDetail.description
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 30),
            // child: InkWell(
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Icon(Icons.arrow_back_ios_new),
            // ),
            child: IconButton (
              onPressed: () {
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back_ios_new),
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.1)),
              child: const Icon(
                Icons.favorite_border_outlined,
                color: AppColor.ColorMain,
                size: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // add list new group
              widget.homeProvider.setListGroup(widget.homeProvider.productDetail!.newGroup);
              _listGroup.clear();
              _listGroup.addAll(widget.homeProvider.listGroup);
              imageUrl = widget.homeProvider.productDetail!.images[0];
              titleProduct = widget.homeProvider.productDetail!.title;
              selectProductType();
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3*2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: AppColor.ColorMain),
              child: const Center(
                child: Text(
                  StringConstant.buy_button_title,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget rating(double rate) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        const SizedBox(width: 5),
        Text('$rate / 5')
      ],
    );
  }

  void selectProductType() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height / 4 * 3,
            child: BuyProductScreen(listGroup: _listGroup, imageUrl: imageUrl, titleProduct: titleProduct, productID: widget.productID,));
      },
    );
  }
}
