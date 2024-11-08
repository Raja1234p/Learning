import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/blocs/authentication/authentication_bloc.dart';
import 'package:learning/blocs/dashboard/dashboard_bloc.dart';
import 'package:learning/repositories/authentication_repositories.dart';
import 'package:learning/views/authenticate/authenticate_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(AuthenticationRepository()),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc()..add(DefaultComplaintEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthenticatedScreen(),
      ),
    );
  }
}
