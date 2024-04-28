import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:flutter/material.dart';

import '../../../models/home_model/checkout_model.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({
    super.key,
    required this.listCheckOut,
  });

  final List<CheckOutModel> listCheckOut;

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {

  double subTotal = 0;
  double discountTotal = 0;
  double totalPayment = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calTotalPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check out'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressUser(),
              const Divider(height: 10, thickness: 1, color: Colors.black26),
              for (var checkoutProduct in widget.listCheckOut)
                productInfor(
                    checkoutProduct.imageUrl,
                    checkoutProduct.titleProduct,
                    checkoutProduct.price,
                    checkoutProduct.quantity),
              const Divider(height: 10, thickness: 1, color: Colors.black26),
              _buildTitle(const Icon(Icons.discount, color: AppColor.ColorMain), StringConstant.voucher),
              _buildDiscount(),
              const Divider(height: 10, thickness: 1, color: Colors.black26),
              _buildTitle(const Icon(Icons.event_note, color: AppColor.ColorMain), StringConstant.paymet_details),
              _buildPaymentDetail()
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar());
  }

  Widget bottomNavigationBar() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(StringConstant.total_payment),
                Text('\$$totalPayment')
              ],
            ),
          ),
          InkWell(
            onTap: () {

            }, child: Container (
            margin: const EdgeInsets.only(left:5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration (
              color: AppColor.ColorMain,
            ),
            child: const Center (
              child: Text (StringConstant.place_order, style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500
              )),
            ),
          ),
          )
        ],
      ),
    );
  }

  Widget addressUser() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(5),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20,
            color: AppColor.ColorMain,
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(StringConstant.delivery_address), Text('Ha noi')],
          )
        ],
      ),
    );
  }

  Widget productInfor(String imageUrl, String title, int price, int quantity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.black.withOpacity(0.01),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            height: 100,
            width: 100,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('\$$price'), Text('x$quantity')],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildDiscount() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: DropdownMenu(
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 5, label: 'Giam 5%'),
            DropdownMenuEntry(value: 15, label: 'Giam 15%'),
          ],
          onSelected: (value) {
            calTotalPayment();
            discountTotal = totalPayment * value! / 100;
            totalPayment -= discountTotal;
            setState(() {});
          },
          width: MediaQuery.of(context).size.width - 20,
          leadingIcon: const Icon(Icons.discount, color: AppColor.ColorMain),
          hintText: 'Select voucher',
        ));
  }

  Widget _buildPaymentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Merchandise Subtotal'),
              Text('Shipping Subtotal'),
              Text('Voucher Discount'),
              Text('Total Payment')
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$$subTotal'),
              Text('Free'),
              Text('-\$$discountTotal'),
              Text('\$$totalPayment')
            ],
          )
        ],

      ),
    );
  }

  Widget _buildTitle(Icon icon, String title) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row (
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400
          ),)
        ],
      ),
    );
  }

  void calTotalPayment() {
    totalPayment = 0;
    subTotal = 0;
    for (var product in widget.listCheckOut) {
      totalPayment += (product.price * product.quantity);
      subTotal += (product.price * product.quantity);
    }
    setState(() {});
  }
}
