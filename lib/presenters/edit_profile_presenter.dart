import 'dart:convert';
import 'dart:typed_data';
import 'package:do_an_mobile/data_sources/repositories/app_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:do_an_mobile/data_sources/repositories/auth_repository.dart';
import 'package:do_an_mobile/models/home_model/history_purchase_model.dart';
import 'package:do_an_mobile/models/user_infor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../Utils/image_picker.dart';
import '../data_sources/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

abstract class EditProfileViewContract {
  void editProfileComplete();
  void editProfileError(String msg);
  void uploadImageComplete(String imageUrl);
  void uploadImageError(String msg);
}

class EditProfilePresenter {
  EditProfileViewContract? _view;
  EditProfilePresenter(this._view);

  Future editProfile(String email, String username, String address, String phone, String imageUrl) async {
    AuthRepositoryImpl.shared.editProfile(email, username, address, phone, imageUrl).then((value) {
      print(value);
      EditProfileModel model = EditProfileModel.fromJson(jsonDecode(value));
      if (model.code == 200) {
        _setUserInfor(
            model.user.token, username, model.user.avatar, phone, address,
            email);
        _view!.editProfileComplete();
      } else {
        _view!.editProfileError(model.message);
      }
    }).catchError((onError) {
      _view!.editProfileError(onError.toString());
    });
  }

  Future uploadImage(String avatarUrl) async {
    // final url = Uri.parse('https://api.cloudinary.com/v1_1/${StringConstant.cloudName}/upload');
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dupo0r5fh/upload');
    final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = 'rxbdgjes'
    ..files.add(await http.MultipartFile.fromPath('file', avatarUrl));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      final url = jsonMap['url'];
      _view!.uploadImageComplete(url);
    } else {
      _view!.uploadImageError('upload image fail');
    }
  }

  Future _setUserInfor(
      String token, String username,
      String avatar, String phone, String address, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StringConstant.key_token, token);
    prefs.setString(StringConstant.phone_number, phone);
    prefs.setString(StringConstant.username, username);
    prefs.setString(StringConstant.address, address);
    prefs.setString(StringConstant.avatarUrl, avatar);
    prefs.setString(StringConstant.email, email);
  }

  Future imagePicker() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    final documentDirectory = await getApplicationCacheDirectory();

    final file = File('${documentDirectory.path}/avt.png');
    await file.writeAsBytes(img);
    return file.path;
  }

  Future<String> getAvatar() async {
    final documentDirectory = await getApplicationCacheDirectory();
    final file = File('${documentDirectory.path}/avt.png');
    return file.path;
  }
}