import 'package:cloud_firestore/cloud_firestore.dart';
import "package:get/get.dart";

class SearchService extends GetxController {
  Future searchByName(String collection) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection("RoomData")
        .where("roomPlace", isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
