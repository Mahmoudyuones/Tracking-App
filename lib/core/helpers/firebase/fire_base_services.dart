import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@singleton
class FireStoreService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  FirebaseFirestore get fireStore => _fireStore;
  FirebaseDatabase get firebaseDatabase => _firebaseDatabase;
}
