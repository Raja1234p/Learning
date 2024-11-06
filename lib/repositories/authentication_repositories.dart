import 'package:learning/constants/url_constants.dart';
import 'package:learning/models/request/authentication_request_model.dart';

import '../network/dio_client.dart';

class AuthenticationRepository {
  final DioClient _dioClient = DioClient();

  Future fetchUsers(
      AuthenticationRequestModel authenticationRequestModel) async {
    try {
      final response = await _dioClient.dio.get(UrlConstants.authenticate,
          queryParameters: authenticationRequestModel.toMap());
      return response;
    } catch (error) {
      throw Exception("Failed to load users");
    }
  }
}
