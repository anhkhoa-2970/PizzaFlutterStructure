import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:testxxxx/core/network_services/error_handler.dart';
import 'package:testxxxx/domain/entities/my_user_entity.dart';
import 'package:testxxxx/domain/repositories/authenticaiton_repository.dart';

import '../../utils/constants.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationImpl implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(errorFromFirebase, '${e.message}'));
    } catch (e) {
      return Left(Failure(errorFromFirebase, 'Unknown error...'));
    }
  }

  @override
  Future<Either<Failure, void>> setUserData(MyUserEntity myUser) async {
    try {
      await userCollection.doc(myUser.phoneNumber).set(myUser.toJson());
      return const Right(null);
    } catch (e) {
      return Left(Failure(errorFromFirebase, '$e'));
    }
  }

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      // String errorMessage = "Failed to sign in";
      // if (e is FirebaseAuthException) {
      //   switch (e.code) {
      //     case 'invalid-email':
      //       errorMessage = 'Invalid email address';
      //       break;
      //     case 'user-not-found':
      //       errorMessage = 'User not found';
      //       break;
      //     case 'wrong-password':
      //       errorMessage = 'Wrong password';
      //       break;
      //     default:
      //       errorMessage = 'Error: ${e.message}';
      //   }
      // }
      return Left(Failure(errorFromFirebase, '${e.message}'));
    } catch (e) {
      return Left(Failure(errorFromFirebase, 'Unknown error...'));
    }
  }

  @override
  Future<Either<Failure, MyUserEntity>> signUp(MyUserEntity myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: myUser.email ?? '', password: password);
      myUser.phoneNumber = user.user?.uid;
      return Right(myUser);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(errorFromFirebase, '${e.message}'));
    } catch (e) {
      return Left(Failure(errorFromFirebase, 'Unknown error...'));
    }
  }

  @override
  Stream<Either<Failure, MyUserEntity>> get user {
    return _firebaseAuth.authStateChanges().asyncExpand((firebaseUser) async* {
      if (firebaseUser == null) {
        yield Left(Failure(errorFromFirebase, 'User not authenticated'));
      } else {
        try {
          var snapshot = await userCollection.doc(firebaseUser.uid).get();
          var userData = snapshot.data();
          if (userData != null) {
            yield Right(MyUserEntity.fromJson(userData));
          } else {
            yield Left(Failure(errorFromFirebase, "User data not found"));
          }
        } catch (e) {
          yield Left(Failure(errorFromFirebase, "Error fetching user data: $e"));
        }
      }
    });
  }
}
