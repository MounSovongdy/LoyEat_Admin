import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/remote_data.dart';

class OrderDetailController extends GetxController {
  var customerId = ''.obs;
  var customerName = ''.obs;
  var merchantId = ''.obs;
  var merchantName = ''.obs;
  var deliveryFee = ''.obs;
  var distance = ''.obs;
  var listImage = [];
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

    final _productImageData =
      RemoteData<List>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List> get productImageData => _productImageData.value;


  var data = false.obs;

  var count = 1.obs;
  var proId = ''.obs;
  var proPrice = ''.obs;
  var qty = 0.obs;

  // for firebase
  var listOrder = [];
  var mapProduct = {};

  // for show data
  var showOrder = [];
  var showProduct = {};

  void incrementCounter() {
    count++;
  }

  void decrementCounter() {
    count--;
    if (count.value == 0) {
      count.value = 1;
    }
  }

  loadProductData() async {
    listImage.clear();
    listProductName.clear();
    listProductPrice.clear();

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
        listImage.add(data['image']);
        listProductName.add(data['product_name']);
        listProductPrice.add(data['price']);

        _productNameData.value = RemoteData<List>(
            status: RemoteDataStatus.success, data: listProductName);
        _productPriceData.value = RemoteData<List>(
            status: RemoteDataStatus.success, data: listProductPrice);
         _productImageData.value = RemoteData<List>(
            status: RemoteDataStatus.success, data: listImage);
      }
    });
  }

  loadProductID(String name) {
    final product = products.where('product_name', isEqualTo: name).snapshots();
    product.listen((event) {
      for (var element in event.docs) {
        proId.value = element['product_id'];
      }
    });
  }
}
