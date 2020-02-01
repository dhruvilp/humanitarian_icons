import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/authentication.dart';
import 'blocs/auth/authentication.dart';
import 'blocs/auth/authentication_bloc.dart';
import 'blocs/auth/authentication_event.dart';
import 'blocs/auth/authentication_state.dart';
import 'blocs/bloc_delegate.dart';
import 'blocs/login/login_page.dart';
import 'style.dart';
import 'ui/pages/Dashboard.dart';
import 'ui/widgets/LoadingIndicator.dart';
import 'ui/widgets/PatientProfileData.dart';
import 'ui/widgets/SplashPage.dart';
import 'models/user.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  final user = User();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) {
        return AuthenticationBloc(user: user)..add(AppStarted());
      },
      child: ETriageApp(user: user),
    ),
  );
}

class ETriageApp extends StatelessWidget {
  final User user;

  ETriageApp({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return DashboardPage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(user: user);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: cyan,
        primaryColorLight: off_cyan,
        primaryColorDark: cyan_dark,
        accentColor: pink,
        scaffoldBackgroundColor: white,
        fontFamily: 'Quicksand',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: cyan, width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          fillColor: pink,
          labelStyle: TextStyle(
            color: cyan,
          ),
        ),
      ),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new LoginPage(user: user,),
        '/dashboard' : (BuildContext context) => new DashboardPage(),
        '/patientProfileData' : (BuildContext context) => new PatientProfileData(),
      },
    );
  }
}