import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/remote_data.dart';

class AdminController extends GetxController {

  var listDriverName = [];
  var listIdCard = [];
  var listBirth = [];
  var listTel = [];

  final driverCollection = FirebaseFirestore.instance.collection('drivers');

  final _driver = RemoteData<List>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List> get driverData => _driver.value;


  @override
  void onInit() {
    loadDriver();
    super.onInit();
  }

  void loadDriver() {
    listDriverName.clear();
    listIdCard.clear();
    listBirth.clear();
    listTel.clear();

   final driver = driverCollection.where('status', isNotEqualTo: 'Approved').snapshots();
   driver.listen((value) {
     if (value.docs.isNotEmpty) {
       for (var data in value.docs) {
         listDriverName.add(data['driver_name']);
         listIdCard.add(data['id_card']);
         listBirth.add(data['YOB']);
         listTel.add(data['tel']);
         _driver.value = RemoteData<List>(status: RemoteDataStatus.success, data: listDriverName);
       }
     }
     else {
       _driver.value = RemoteData<List>(status: RemoteDataStatus.none, data: null);
     }
   });
  }

  void approveDriver(String tel) {
    driverCollection.where('tel', isEqualTo: tel).get().then((value) {
      for (var element in value.docs) {
        var driverDoc = element.id;

        driverCollection.doc(driverDoc).update({
          'status': 'Approved',
        });
      }
    });
  }
  void rejectDriver(String tel) {
    driverCollection.where('tel', isEqualTo: tel).get().then((value) {
      for (var element in value.docs) {
        var driverDoc = element.id;

        driverCollection.doc(driverDoc).delete();
      }
    });
  }
}