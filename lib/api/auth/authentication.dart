import 'dart:developer';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:flutter/foundation.dart';

class Authentication {
  final Client client;

  late Account account;

  Authentication(this.client) {
    account = Account(client);
  }

  //  A function which returns an Account object containing the data
  //  of the user if the user is authenticated else it returns null
  Future<appwrite_models.Account?> getAccount() async {
    try {
      return await account.get();
    } on AppwriteException catch (e) {
      log(e.toString());
      return null;
    }
  }

  // A function to login the user with email and password
  Future<void> login(String email, String password) async {
    try {
      await account.createEmailSession(email: email, password: password);
    } on Exception catch (e) {
      debugPrint('Logged Error\n${e.toString()}');
      rethrow;
    }
  }

  ///  A function to signup the user with email and password
  Future<void> signUp(String email, String password, String name) async {
    try {
      await account.create(
          email: email, password: password, userId: 'unique()', name: name);

      await account.createEmailSession(email: email, password: password);
    } on Exception catch (e) {
      debugPrint('Logged Error\n${e.toString()}');
      rethrow;
    }
  }

  ///  A function to logout the current user
  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
    } on Exception catch (e) {
      debugPrint('Logged Error\n${e.toString()}');
      rethrow;
    }
  }
}
