import 'package:do_an_mobile/core/network_monitor.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkMonitor>(NetworkMonitor(), permanent: true);
  }
}