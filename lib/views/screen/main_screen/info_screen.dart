import 'package:do_an_mobile/core/app_assets.dart';
import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/providers/AuthProvider.dart';
import 'package:do_an_mobile/providers/info_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/edit_profile_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/history_purchase_screen.dart';
import 'package:do_an_mobile/views/screen/main_screen/main_screen.dart';
import 'package:do_an_mobile/views/widget/loading_animation_widget.dart';
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

class _InformationViewState extends State<InformationView> {
  late AuthProvider _authProvider;
  late InforProvider _inforProvider;
  CircleLoading? _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = CircleLoading();
    _authProvider = Provider.of<AuthProvider>(context,listen: false);
    _inforProvider = Provider.of<InforProvider>(context, listen: false);
    getDataHistoryPurchase();
    if (_authProvider.isLogin) {
      if (_inforProvider.isLoading) {
        _loading!.show(context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getDataHistoryPurchase() async {
    if (_authProvider.isLogin) {
      _inforProvider.resetListHistoryPurchase();
      _inforProvider.getHistoryPurchase();
      _inforProvider.setListHistoryPurchase();
    } else {
      _loading!.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _authProvider.isLogin? _buildAppBarIsLogin() : _buildAppBar(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Consumer<InforProvider>(builder: (context, value, child) {
          if (!_inforProvider.isLoading) {
            _loading?.hide();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeliveryProcess(),
              const Divider(color: Colors.black12, height: 1)
            ],
          );
        },)
      ),
    );
  }
  
  PreferredSizeWidget _buildAppBarIsLogin() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: Container (
        color: AppColor.ColorMain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileView(),));
                },
                child: CircleAvatar (
                  radius: 40,
                  child: ClipOval (
                    child: Image.network(
                      _authProvider.userInfor!.avatar.isEmpty?
                      'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg'
                          : _authProvider.userInfor!.avatar, height: 80, width: 80, fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_authProvider.userInfor!.username, style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),),
                      Text(_authProvider.userInfor!.phone, style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                      )),
                      Text('Ranking: ${_authProvider.userInfor!.ranking}', style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Colors.white
                      ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      _inforProvider.resetListHistoryPurchase();
                      _authProvider.logout();
                      if (context.mounted) {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => const MainView())
                        );
                      }
                    },child: const Text(
                      StringConstant.log_out_button_title,
                      style: TextStyle(
                          color: AppColor.ColorMain,
                          fontSize: 14
                      )),
                  ),
                )
              ],
            )
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
      actions: [
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
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(StringConstant.delivery_process, style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HistoryPurchaseScreen())
                        );
                      },
                      child: const Text('View Purchase History', style: TextStyle(
                        fontSize: 13
                      ),),
                    ),
                    const Icon(Icons.navigate_next, size: 20, color: Colors.grey,)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row (
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBadge(AppAsset.icon_check_list, 40, StringConstant.to_pay, _inforProvider.listToPay),
                _buildBadge(AppAsset.icon_box, 40, StringConstant.to_ship, _inforProvider.listToShip),
                _buildBadge(AppAsset.icon_truck, 40,  StringConstant.to_receive, _inforProvider.listToReceive),
                _buildBadge(AppAsset.icon_rating, 40, StringConstant.to_rate, _inforProvider.listToRate),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBadge(String icon, double size, String title, List list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Badge(
          backgroundColor: _checkListLength(list)? Colors.red : Colors.transparent,
          textColor: _checkListLength(list)? Colors.white : Colors.transparent,
          label: Text(list.length.toString()),
          child: InkWell (
            onTap: () {

            },child: Image.asset(icon, height: size),
          ),
        ),
        Text(title, style: const TextStyle (fontWeight: FontWeight.w500, fontSize: 15),)
      ],
    );
  }

  bool _checkListLength(List list) {
    if (list.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
