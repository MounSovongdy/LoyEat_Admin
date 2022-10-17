import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveLoginController extends GetxController {
  SharedPreferences? preferences;
  final String _customerName = "customerName";
  final String _customerId = "customerId";

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }
  Future<bool>? writeCustomerName(String value) {
    return preferences?.setString(_customerName, value);
  }
  String readCustomerName() {
    return preferences?.getString(_customerName) ?? "";
  }
  void removeCustomerName() {
    preferences?.remove(_customerName);
  }

  Future<bool>? writeCustomerId(String value) {
    return preferences?.setString(_customerId, value);
  }
  String readCustomerId() {
    return preferences?.getString(_customerId) ?? "";
  }
  void removeCustomerId() {
    preferences?.remove(_customerId);
  }
}