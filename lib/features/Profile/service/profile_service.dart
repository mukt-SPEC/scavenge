import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/model/user.dart';
import 'package:scavenge/provider/providers.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';

final profileServiceProvider = Provider((ref) {
  return ProfileService(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firestoreProvider),
  );
});

class ProfileService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  ProfileService({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore,
       super();

  Future<UserModel> saveUserFromOnboarding(OnboardingState state) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) throw Exception('No authenticated user found');
      if (state.userType == null) throw Exception('UserType is not selected');

      UserModel userToSave;
      if (state.userType == UserType.customer) {
        userToSave = Customer(
          id: currentUser.uid,
          name: state.name ?? '',
          email: currentUser.email ?? '',
          phoneNumber: state.phoneNumber ?? '',
          preferredWasteTypes: state.preferredWasteTypes ?? [],
        );
      } else if (state.userType == UserType.agent) {
        userToSave = Agent(
          id: currentUser.uid,
          name: state.name ?? '',
          email: currentUser.email ?? '',
          phoneNumber: state.phoneNumber ?? '',
          vehicleLicensePlate: state.vehicleLicensePlate,
        );
      } else {
        throw Exception('Invalid user type');
      }

      await saveUserToDatabase(userToSave);
      return userToSave;
    } catch (e) {
      debugPrint("Error creating user from onboarding: $e");
      rethrow;
    }
  }

  Future<void> saveUserToDatabase(UserModel user) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) throw Exception('No authenticated user found');

    
      UserModel userToSave;
      if (user is Customer) {
        userToSave = user.copyWith(
          id: currentUser.uid,
          email: currentUser.email,
        );
      } else if (user is Agent) {
        userToSave = user.copyWith(
          id: currentUser.uid,
          email: currentUser.email,
        );
      } else {
        throw Exception('Invalid user type');
      }

      
      await _firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .set(userToSave.toMap());
    } catch (e) {
      debugPrint("Error saving user: $e");
      rethrow;
    }
  }

  Future<User?> currentUser() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }

  // Future<UserModel?> saveUser({UserModel? userModel}) async {
  //   try {
  //     final currentUser = _firebaseAuth.currentUser;

  //     if (userModel is Customer) {
  //       Customer customer = userModel.copyWith(
  //         id: _firebaseAuth.currentUser!.uid,
  //         email: _firebaseAuth.currentUser!.email,
  //       );
  //       await _firebaseFirestore
  //           .collection(CollectionPaths.customers)
  //           .doc(_firebaseAuth.currentUser!.uid)
  //           .set(
  //             userModel.copyWith(id: _firebaseAuth.currentUser!.uid).toMap(),
  //           );
  //     }
  //     if (userModel is Agent) {
  //       Agent agent = userModel.copyWith(
  //         id: _firebaseAuth.currentUser!.uid,
  //         email: _firebaseAuth.currentUser!.email,
  //       );
  //       await _firebaseFirestore
  //           .collection(CollectionPaths.agent)
  //           .doc(_firebaseAuth.currentUser!.uid)
  //           .set(
  //             userModel.copyWith(id: _firebaseAuth.currentUser!.uid).toMap(),
  //           );
  //     }
  //   } catch (e) {}
  // }

  // Future<UserModel?> fetchUser({String? id, UserType? userType}) async {
  //     try {
  //       final qSnap = await _firebaseFirestore
  //           .collection(CollectionPaths.users)
  //           .where('id', isEqualTo: id ?? _firebaseAuth.currentUser!.uid)
  //           .get();
  //       if (qSnap.docs.isEmpty) return null;
  //       //return qSnap.docs.map((doc) => UserModel);
  //     } on SocketException catch (_) {
  //       throw NoInternetException();
  //     } catch (e) {}
  //   }
  Future<UserModel?> getCurrentUser() async {
    try {
      final uid = _firebaseAuth.currentUser?.uid;
      if (uid == null) return null;

      final docSnapshot = await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        return UserModel.fromMap(docSnapshot.data()!);
      }
      return null;
    } catch (e) {
      debugPrint("Error fetching user: $e");
      return null;
    }
  }
}
