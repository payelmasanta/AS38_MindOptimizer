import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference resultCollection =
      Firestore.instance.collection('User Data');

  Future updateUserData(
      String result_dry, result_wet, locationMessage, placename) async {
    return await resultCollection.document(uid).setData({
      'Driest Result': result_dry + " litres",
      'Wettest Result': result_wet + "litres",
      'Location Coordinates': locationMessage,
      'District': placename,
    });
  }

  Stream<QuerySnapshot> get results {
    return resultCollection.snapshots();
  }
}
