import 'package:cloud_firestore/cloud_firestore.dart';


class CrudMethods {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection("blogs")
        .add(blogData)
        // ignore: invalid_return_type_for_catch_error, avoid_print
        .catchError((e) => print(e));
  }
getData()async{
  // ignore: await_only_futures
  return await FirebaseFirestore.instance.collection("blogs").snapshots();
}

}
