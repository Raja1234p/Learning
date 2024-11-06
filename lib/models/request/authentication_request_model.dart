import 'dart:convert';

class AuthenticationRequestModel {
  final int chefId;
  final String currentPassword;
  final String apiKey;

  AuthenticationRequestModel({
    required this.chefId,
    required this.currentPassword,
    required this.apiKey,
  });

  // Convert the model to a Map (to send as JSON in an API request)
  Map<String, dynamic> toMap() {
    return {
      'ChefId': chefId,
      'CurrentPassword': currentPassword,
      'APIKey': apiKey,
    };
  }
}
