import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:get/get.dart';

class NetworkMonitor extends GetxController {
  final Connectivity _connectivity = Connectivity();

  static final shared = NetworkMonitor();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      AppShowToast.showToast('Please checking your network!');
      // Get.rawSnackbar(
      //   messageText: const Text('Please checking your network!', style: TextStyle(
      //     fontSize: 14,
      //     color: Colors.white
      //   ),),
      //   isDismissible: false,
      //   duration: const Duration(days: 1),
      //   backgroundColor: Colors.red,
      //   icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
      //   margin: EdgeInsets.zero,
      //   snackStyle: SnackStyle.FLOATING
      // );
    } else {
      AppShowToast.showToast('connect internet success!');
      // if (Get.isSnackbarOpen) {
      //   Get.closeCurrentSnackbar();
      // }
    }
  }
}