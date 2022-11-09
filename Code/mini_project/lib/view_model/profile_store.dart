import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_project/models/profile_store.dart';

class ProfileStoreViewModel extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference refInstance = FirebaseStorage.instance.ref();

  Future<void> addDataProfile(ProfileStore data) async {
    CollectionReference dataFirestore = firestore.collection('dataStore');
    try {
      dataFirestore.doc(data.id).set({
        'nameStore': data.nameStore,
        'addressStore': data.addressStore,
        'numberStore': data.numberStore,
      });
    } on FirebaseException catch (e){
      if (kDebugMode) {
        print(e);
      
      }rethrow;
    }
  }

  Stream<DocumentSnapshot<Object?>> getDataProfile() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final dataId = auth.currentUser!.uid;

    CollectionReference documentStream =
        FirebaseFirestore.instance.collection('dataStore');
    final data = documentStream.doc(dataId).snapshots();

    return data;
  }

  Future<void> addDataImgProfile(ProfileStore data) async {
    CollectionReference dataFirestore = firestore.collection('imageUser');
    try {
      dataFirestore.doc(data.id).set(
        {
          'imageUrl': data.imageUrl,
        },
      );
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Object?>> getDataImgProfile() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final dataId = auth.currentUser!.uid;

    CollectionReference documentStream =
        FirebaseFirestore.instance.collection('imageUser');
    final data = documentStream.doc(dataId).snapshots();

    return data;
  }
}
