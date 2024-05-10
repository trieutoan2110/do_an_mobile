import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/models/home_model/history_purchase_model.dart';
import 'package:do_an_mobile/providers/info_provider.dart';
import 'package:do_an_mobile/views/widget/empty_widget.dart';
import 'package:do_an_mobile/views/widget/home/product_infor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPurchaseScreen extends StatefulWidget {
  const HistoryPurchaseScreen({super.key});

  @override
  State<HistoryPurchaseScreen> createState() => _HistoryPurchaseScreenState();
}

class _HistoryPurchaseScreenState extends State<HistoryPurchaseScreen> {
  late InforProvider inforProvider;

  String statusRate = 'Terrible';
  double rate = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inforProvider = Provider.of<InforProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Purchases'),
            bottom: const TabBar(
              isScrollable: true,
              physics: AlwaysScrollableScrollPhysics(),
              tabs: [
                Tab(child: Text(StringConstant.to_pay)),
                Tab(child: Text(StringConstant.to_ship)),
                Tab(child: Text(StringConstant.to_receive)),
                Tab(child: Text(StringConstant.to_rate)),
                Tab(child: Text(StringConstant.complete)),
                Tab(child: Text(StringConstant.cancelled)),
                // Tab(child: Text(StringConstant.return_refund))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildListHistory(inforProvider.listToPay, true, true, false),
              _buildListHistory(inforProvider.listToShip, false, false, false),
              _buildListHistory(
                  inforProvider.listToReceive, false, false, false),
              _buildListHistory(inforProvider.listToRate, true, false, false),
              _buildListHistory(inforProvider.listCompleted, true, false, true),
              _buildListHistory(inforProvider.listCancel, true, false, true),
              // _buildListHistory(widget.inforProvider.listReturnRefund),
            ],
          ),
        ));
  }

  Widget _buildListHistory(
      List<Product> list, bool isRate, bool isCancel, bool isBuyAgain) {
    return list.isEmpty
        ? const EmptyWidget()
        : ListView.builder(
            itemCount: list.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Product product = list[index];
              return Container(
                  child: ProductInforWidget(
                productID: product.productId,
                title: product.inforProduct.title,
                imageUrl: product.inforProduct.images[0],
                quantity: product.quantity,
                price: product.inforProduct.productChild.priceNew,
                childTitle: product.childTitle,
                isRate: isRate,
                isCancel: isCancel,
                isBuyAgain: isBuyAgain, index: index,
              ));
            },
          );
  }
}
