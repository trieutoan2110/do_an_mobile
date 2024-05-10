import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/presenters/checkout_success_presenter.dart';
import 'package:do_an_mobile/providers/AuthProvider.dart';
import 'package:do_an_mobile/providers/checkout_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/checkout_complete_screen.dart';
import 'package:do_an_mobile/views/widget/home/product_infor_widget.dart';
import 'package:do_an_mobile/views/widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

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

class _CheckOutViewState extends State<CheckOutView> implements CheckOutSuccessViewContract{

  double subTotal = 0;
  double discountTotal = 0;
  double totalPayment = 0;
  late CheckOutProvider _checkOutProvider;
  late AuthProvider _authProvider;
  CheckOutSuccessPresenter? _presenter;
  late List<Map<String, dynamic>> listProduct = [];
  String discountID = '';
  TextEditingController addressController = TextEditingController();
  CircleLoading? _loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkOutProvider = Provider.of<CheckOutProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _presenter = CheckOutSuccessPresenter(this);
    _loading = CircleLoading();
    addressController.setText(_authProvider.userInfor!.address);
    calTotalPayment();
    getData();
  }

  void getData() {
    _checkOutProvider.getListDiscount();
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
                ProductInforWidget(
                    productID: checkoutProduct.productID,
                    imageUrl: checkoutProduct.imageUrl,
                    title: checkoutProduct.titleProduct,
                    price: checkoutProduct.price,
                    quantity: checkoutProduct.quantity,
                    childTitle: checkoutProduct.childTitle,
                    isCancel: false,
                    isRate: false,
                  isBuyAgain: false, index: 0,
                ),
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
              _loading!.show(context);
              String fullname = _authProvider.userInfor!.username;
              String phone = _authProvider.userInfor!.phone;
              String address = addressController.text.isEmpty ? _authProvider.userInfor!.address : addressController.text;
              setLitsProductCheckOut();
              _presenter!.checkoutSuccess(fullname, phone, address, discountID, listProduct);
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
      child: TextField(
        controller: addressController,
        decoration: const InputDecoration(
          // hintText: 'Ha Noi',
          labelText: StringConstant.address,
          prefixIcon: Icon(Icons.location_on_outlined, size: 30, color: AppColor.ColorMain,),
        ),
      ),
    );
  }

  Widget _buildDiscount() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: DropdownMenu(
          dropdownMenuEntries: [
            for (var discount in _checkOutProvider.listDiscount)
              DropdownMenuEntry(value: discount.discountPercent, label: discount.title)
          ],
          onSelected: (value) {
            calTotalPayment();
            discountTotal = totalPayment * value! / 100;
            totalPayment -= discountTotal;
            for (var discount in _checkOutProvider.listDiscount) {
              if (discount.discountPercent == value) {
                discountID = discount.id;
              }
            }
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
              SizedBox(height: 5),
              Text('Shipping Subtotal'),
              SizedBox(height: 5),
              Text('Voucher Discount'),
              SizedBox(height: 5),
              Text('Total Payment')
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$$subTotal'),
              const SizedBox(height: 5),
              const Text('Free'),
              const SizedBox(height: 5),
              Text('-\$$discountTotal'),
              const SizedBox(height: 5),
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

  void setLitsProductCheckOut() {
    for (var product in widget.listCheckOut) {
      Map<String, dynamic> body = {
        "product_id": product.productID,
        "childTitle": product.childTitle,
        "quantity": product.quantity
      };

      listProduct.add(body);
    }
  }

  @override
  void checkOutComplete() {
    _loading!.hide();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckOutComplete(),));
  }

  @override
  void checkOutError(String msg) {
    _loading!.hide();
    AppShowToast.showToast(msg);
  }
}
