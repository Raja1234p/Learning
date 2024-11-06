import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/blocs/authentication/authentication_bloc.dart';

class AuthenticatedScreen extends StatelessWidget {
  const AuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authenticate'),
      ),
      body: Center(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('you are authorized')),
            );
          } else if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthenticationBiometricsUnavailable) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Local authentication is not available on this device.')),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthenticationInProgress) {
            return const CircularProgressIndicator(); // Show loading indicator
          }
          return ElevatedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(AuthenticateEvent());
            },
            child: const Text('Authenticate using Biometrics or PIN'),
          );
        },
      )),
    );
  }
}
