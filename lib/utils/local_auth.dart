import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

enum SupportState { unknown, supported, unsupported }

class LocalAuthUtil {
  // Singleton instance
  static final LocalAuthUtil instance = LocalAuthUtil._();

  final LocalAuthentication _auth = LocalAuthentication();

  SupportState _supportState = SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;

  // Private constructor
  LocalAuthUtil._() {
    _checkDeviceSupport();
  }

  // Check if the device supports biometrics
  Future<void> _checkDeviceSupport() async {
    bool isSupported = await _auth.isDeviceSupported();
    _supportState =
        isSupported ? SupportState.supported : SupportState.unsupported;
  }

  // Check if biometrics are available on the device
  Future<bool> canCheckBiometrics() async {
    try {
      _canCheckBiometrics = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error checking biometrics: ${e.message}");
      }
      _canCheckBiometrics = false;
    }
    return _canCheckBiometrics ?? false;
  }

  // Get available biometric types (e.g., fingerprint, face)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      _availableBiometrics = await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error getting available biometrics: ${e.message}");
      }
      _availableBiometrics = <BiometricType>[];
    }
    return _availableBiometrics ?? <BiometricType>[];
  }

  // Authenticate using any available method (biometric or device credential)
  Future<bool> authenticate() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error during authentication: ${e.message}");
      }
    }
    return isAuthenticated;
  }

  // Authenticate using biometrics only
  Future<bool> authenticateWithBiometrics() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _auth.authenticate(
        localizedReason: 'Please authenticate using biometrics',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Error during biometric authentication: ${e.message}");
      }
    }
    return isAuthenticated;
  }

  // Cancel ongoing authentication
  Future<void> cancelAuthentication() async {
    try {
      await _auth.stopAuthentication();
    } catch (e) {
      if (kDebugMode) {
        print("Error canceling authentication: $e");
      }
    }
  }
}
