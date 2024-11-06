import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:learning/models/request/authentication_request_model.dart';
import 'package:learning/repositories/authentication_repositories.dart';
import 'package:learning/utils/local_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  // Using the LocalAuthUtil singleton for authentication handling
  final LocalAuthUtil _authUtil = LocalAuthUtil.instance;
  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      // Call the helper function to check biometrics availability
      await _checkBiometricsAvailability(emit);
    });
  }
  // Helper function to check biometrics availability
  Future<void> _checkBiometricsAvailability(
      Emitter<AuthenticationState> emit) async {
    bool biometricsAvailable = await _authUtil.canCheckBiometrics();

    if (!biometricsAvailable) {
      // Emit AuthenticationBiometricsUnavailable if biometrics are unavailable
      emit(AuthenticationBiometricsUnavailable());
      return;
    }

    // Proceed to start the authentication process
    await _startAuthenticationProcess(emit);
  }

  // Helper function to start the authentication process
  Future<void> _startAuthenticationProcess(
      Emitter<AuthenticationState> emit) async {
    // Emit AuthenticationInProgress state when authentication starts
    emit(AuthenticationInProgress());

    try {
      // Perform authentication using LocalAuthUtil
      bool isAuthenticated = await _authUtil.authenticate();

      if (isAuthenticated) {
        await _authenticateWithAPI(emit);
      } else {
        // Emit AuthenticationFailure state if authentication fails
        emit(const AuthenticationFailure('you are not authorized'));
      }
    } on PlatformException catch (e) {
      // Catch any platform-specific errors and emit failure state
      emit(AuthenticationFailure('Error during authentication: ${e.message}'));
    }
  }

  // Function to handle API authentication request
  Future<void> _authenticateWithAPI(Emitter<AuthenticationState> emit) async {
    try {
      // Prepare the request model
      AuthenticationRequestModel requestModel = AuthenticationRequestModel(
        chefId: 3, // Example chefId
        currentPassword: '123', // Example password
        apiKey: 'mobileapi19042024', // Example API Key
      );

      // Call the repository method
      final response = await _authenticationRepository.fetchUsers(requestModel);

      if (response != null) {
        // Successfully authenticated via the API
        emit(AuthenticationSuccess());
      } else {
        // API authentication failed
        emit(
            const AuthenticationFailure("Failed to authenticate with the API"));
      }
    } catch (e) {
      emit(AuthenticationFailure("Error during API authentication: $e"));
    }
  }
}
