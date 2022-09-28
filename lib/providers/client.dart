import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!) // Your Appwrite Endpoint
      .setProject(dotenv.env['PROJECT_ID']!) // Your project ID
      .setSelfSigned(
          status:
              true); // For self signed certificates, only use for development
});
