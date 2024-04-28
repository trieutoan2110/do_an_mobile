import 'package:do_an_mobile/core/app_assets.dart';
import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/providers/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_screen/login_view.dart';
import '../auth_screen/register_view.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key});

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView>{
  late AuthProvider _authProvider;
  late bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column (
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryProcess()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar (
      backgroundColor: AppColor.ColorMain,
      leading: IconButton (
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const loginView())
          );
        },icon: const Icon(
          Icons.account_circle,
          size: 40, color:
      Colors.white
      ),
      ),
      actions: _authProvider.isLogin ? [
        IconButton(onPressed: () {

        }, icon:const Icon(Icons.settings, size: 35, color: Colors.white))
      ] : [
        Container(
          width: 100,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const loginView())
              );
            },child: const Text(
              StringConstant.sign_in_button_title,
              style: TextStyle(
                  color: AppColor.ColorMain,
                  fontSize: 14
              )),
          ),
        ),
        Container(
          width: 100,
          height: 35,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            //color: Colors.white,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(0),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RegisterView())
              );
            },child: const Text(
              StringConstant.sign_up_button_title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
              )
          ),
          ),
        )
      ],
    );
  }

  Widget _buildDeliveryProcess() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(StringConstant.delivery_process, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),),
          ),
          const SizedBox(height: 20),
          Row (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBadge(AppAsset.icon_check_list, 40, '3', StringConstant.to_pay),
                _buildBadge(AppAsset.icon_box, 40, '3',StringConstant.to_ship),
                _buildBadge(AppAsset.icon_truck, 40, '3', StringConstant.to_receive),
                _buildBadge(AppAsset.icon_rating, 40, '3', StringConstant.to_rate),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPurchaseHistory() {
    return ListView(

    );
  }

  Widget _buildBadge(String icon, double size, String text, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Badge(
          backgroundColor: Colors.transparent,
          textColor: Colors.transparent,
          label: Text(text),
          child: InkWell (
            onTap: () {

            },child: Image.asset(icon, height: size),
          ),
        ),
        Text(title, style: const TextStyle (fontWeight: FontWeight.w500, fontSize: 15),)
      ],
    );
  }
}
