import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/core/collection_path.dart';
import 'package:scavenge/model/user.dart';

class ProfileService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  ProfileService({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore,
       super();

  Future<UserModel> createUser(String name, UserType userType) async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      if (currentUser == null) {
        throw Exception('an unexpected error occured');
      }

      UserModel newUser;
      if (userType == UserType.agent) {
        newUser = Agent(
          id: _firebaseAuth.currentUser!.uid,
          name: name,
          email: _firebaseAuth.currentUser!.email!,
          phoneNumber: '',
        );
      } else {
        newUser = Customer(
          id: _firebaseAuth.currentUser!.uid,
          name: name,
          email: _firebaseAuth.currentUser!.email!,
          phoneNumber: '',
        );
      }

      await _firebaseFirestore
          .collection(CollectionPaths.users)
          .doc(currentUser.uid)
          .set(newUser.toMap());

      return newUser;
    } catch (e) {
      debugPrint("Error in createUser: $e");
      rethrow;
    }
  }
}
