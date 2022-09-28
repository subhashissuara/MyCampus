import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_campus/providers/client.dart';

import '../api/auth/authentication.dart';

final authProvider = Provider<Authentication>((ref) {
  return Authentication(ref.watch(clientProvider));
});

final userProvider = FutureProvider<Account?>((ref) async {
  return ref.watch(authProvider).getAccount();
});

final userLoggedInProvider = StateProvider<bool?>((ref) {
  return null;
});
