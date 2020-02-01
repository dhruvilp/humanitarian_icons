import 'package:etriage/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/authentication.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {
  final User user;

  LoginPage({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            user: user,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
