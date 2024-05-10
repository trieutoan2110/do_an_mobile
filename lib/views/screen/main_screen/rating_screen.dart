import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/presenters/feedback_presenter.dart';
import 'package:do_an_mobile/providers/info_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/main_screen.dart';
import 'package:do_an_mobile/views/widget/home/product_infor_widget.dart';
import 'package:do_an_mobile/views/widget/loading_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key, required this.productInforWidget});
  final ProductInforWidget productInforWidget;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> implements FeedbackViewContract{

  String statusRate = 'Terrible';
  double rate = 0;
  late TextEditingController feedbackController = TextEditingController();
  late FeedbackPresenter _presenter;
  CircleLoading? _loading;
  InforProvider? _provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = FeedbackPresenter(this);
    _loading = CircleLoading();
    _provider = Provider.of<InforProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: const Text('Rate Product'),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.productInforWidget,
          const Divider(color: Colors.black26,height: 40, thickness: 1),
          _buildRating(),
          Container(
            margin: const EdgeInsets.all(10),
            color: Colors.black12.withOpacity(0.05),
            child: TextField(
              controller: feedbackController,
              decoration: const InputDecoration (
                border: OutlineInputBorder(),
                hintText: 'Share more thoughts on the product to help other buyers.',
              ),
              maxLines: 6,
            ),
          )
        ],
      )
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container (
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 60,
      decoration: BoxDecoration (
        borderRadius: BorderRadius.circular(30),
        color: AppColor.ColorMain,
      ),
      child: InkWell (
        onTap: () {
          _loading!.show(context);
          String comment = feedbackController.text;
          _presenter.feedback(widget.productInforWidget.productID,
              _provider!.listOrderIDByProduct[widget.productInforWidget.index],
              widget.productInforWidget.childTitle, comment, rate);
        },
        child: const Center(
            child: Text(StringConstant.submit,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
              ),
            )
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text(
            StringConstant.product_quantity,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 10),
          RatingBar.builder(
            initialRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            minRating: 1,
            itemSize: 30,
            itemBuilder: (context, index) {
              return const Icon(Icons.star, color: AppColor.ColorMain);
            }, onRatingUpdate: (value) {
            rate = value;
            switch (value) {
              case 1: statusRate = StringConstant.terrible;
              case 2: statusRate = StringConstant.poor;
              case 3: statusRate = StringConstant.fair;
              case 4: statusRate = StringConstant.good;
              case 5: statusRate = StringConstant.amazing;
            }
            setState(() {

            });
          },),
          const SizedBox(width: 10),
          Text(statusRate, style: const TextStyle (
              fontSize: 15,
              color: Colors.black54
          ),)
        ],
      ),
    );
  }

  @override
  void onFeedbackComplete() {
    _loading!.hide();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainView()));
    AppShowToast.showToast('Thank you for reviewing the product');
  }

  @override
  void onFeedbackError(String msg) {
    _loading!.hide();
    AppShowToast.showToast(msg);
  }

  @override
  void onCancelComplete() {
    // TODO: implement onCancelComplete
  }

  @override
  void onCancelError(String msg) {
    // TODO: implement onCancelError
  }
}
