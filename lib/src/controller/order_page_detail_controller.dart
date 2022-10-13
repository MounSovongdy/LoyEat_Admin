import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/remote_data.dart';

class OrderPageDetailController extends GetxController {
  var merchantId = ''.obs;
  var merchantName = ''.obs;
  var listProductName = [];
  var listProductPrice = [];

  final merchants = FirebaseFirestore.instance.collection('merchants');
  final products = FirebaseFirestore.instance.collection('products');

  final _productNameData =
      RemoteData<List>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List> get productNameData => _productNameData.value;

  final _productPriceData =
      RemoteData<List>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List> get productPriceData => _productPriceData.value;

  @override
  void onInit() {
    super.onInit();
    merchantName.value = Get.arguments['merchantName'];
    loadProductData();
  }

  loadProductData() async {
    await merchants
        .where('merchant_name', isEqualTo: merchantName.value)
        .get()
        .then((merchant) {
      for (var data in merchant.docs) {
        merchantId.value = data['merchant_id'];
      }
    });

    await products
        .where('merchant_id', isEqualTo: merchantId.value)
        .get()
        .then((product) {
      for (var data in product.docs) {
        listProductName.add(data['product_name']);
        listProductPrice.add(data['price']);

        _productNameData.value = RemoteData<List>(
            status: RemoteDataStatus.success, data: listProductName);
        _productPriceData.value = RemoteData<List>(
            status: RemoteDataStatus.success, data: listProductPrice);
      }
    });
  }
}
