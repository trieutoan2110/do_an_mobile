import 'dart:io';

import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/models/user_infor_model.dart';
import 'package:do_an_mobile/presenters/edit_profile_presenter.dart';
import 'package:do_an_mobile/providers/AuthProvider.dart';
import 'package:do_an_mobile/views/screen/main_screen/main_screen.dart';
import 'package:do_an_mobile/views/widget/loading_animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends
State<EditProfileView> implements EditProfileViewContract{

  TextEditingController usernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  AuthProvider? _authProvider;
  EditProfilePresenter? _presenter;
  CircleLoading? _loading;
  UserInfor? _infor;
  String avatar = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = EditProfilePresenter(this);
    _loading = CircleLoading();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _infor = _authProvider!.userInfor;
    usernameController.setText(_infor!.username);
    addressController.setText(_infor!.address);
    phoneController.setText(_infor!.phone);
    getAvatar();
  }
  
  void getAvatar() async {
    avatar = await _presenter!.getAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Edit Profile'),
      ),
      body: Container (
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () async {
                    await _presenter!.imagePicker();
                    getAvatar();
                    setState(() {
                    });
                  },
                  child: Center(
                    child: ClipOval(
                      child: CircleAvatar (
                        radius: 75,
                        child: avatar == '' ? 
                        Image.network(_infor!.avatar, height: 150, width: 150, fit: BoxFit.cover) :
                        Image.file(File(avatar), height: 150, width: 150, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: -5,
                  right: 100,
                  child: Icon(Icons.edit, size: 30)
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration (
                labelText: StringConstant.username,
              )
            ),
            const SizedBox(height: 5),
            TextField(
                controller: addressController,
                decoration: const InputDecoration (
                  labelText: StringConstant.address,
                )
            ),
            const SizedBox(height: 5),
            TextField(
                controller: phoneController,
                decoration: const InputDecoration (
                  labelText: StringConstant.phone_number,
                ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                _loading!.show(context);
                _presenter!.uploadImage(avatar);
              }, child: Container (
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: MediaQuery.of(context).size.width/3,
              decoration: BoxDecoration (
                borderRadius: BorderRadius.circular(10),
                color: AppColor.ColorMain,
              ),
              child: const Center(
                child: Text(StringConstant.submit, style: TextStyle (
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
                ),),
              ),
            ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void editProfileComplete() {
    // TODO: implement editProfileComplete
    _loading!.hide();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainView()));
  }

  @override
  void editProfileError(String msg) {
    _loading!.hide();
    AppShowToast.showToast(msg);
  }

  @override
  void uploadImageComplete(String imageUrl) {
    String username = usernameController.text.trim();
    String address = addressController.text.trim();
    String phone = phoneController.text.trim();
    print(imageUrl);
    _presenter!.editProfile(_infor!.email, username, address, phone, imageUrl);
  }

  @override
  void uploadImageError(String msg) {
    _loading!.hide();
    AppShowToast.showToast(msg);
  }
}
