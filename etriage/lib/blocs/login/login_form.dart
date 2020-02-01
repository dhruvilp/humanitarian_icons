import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../defaults.dart';
import '../../style.dart';
import 'login.dart';
import 'login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _dialog(String body) async {
      switch (await showDialog(
        context: context,
        builder: (BuildContext context, {barrierDismissible: false}) {
          return new AlertDialog(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Icon(
              Icons.warning,
              color: pink,
              size: 80.0,
            ),
            content: Text(
              body,
              style: TextStyle(
                fontSize: 18,
                color: pink,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                splashColor: white,
                height: 40.0,
                color: cyan,
                onPressed: () {
                  Navigator.pop(context, true);
                },
                padding: const EdgeInsets.all(14.0),
                child: const Text(
                  'OK',
                  style: TextStyle(
                      fontSize: 16, color: white, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      )) {
      }
    }

    _onLoginButtonPressed() {
      if (!Validators.isValidEmail(_usernameController.text)) {
        var error = 'Error: Invalid Email Address!';
        _dialog(error);
      }
      if (!Validators.isValidPassword(_passwordController.text)) {
        var error =
            'Error: Password must be at least 8 characters long, 1 uppercase letter, and 1 number required!';
        _dialog(error);
      }
      if (Validators.isValidEmail(_usernameController.text) &&
          Validators.isValidPassword(_passwordController.text)) {
        BlocProvider.of<LoginBloc>(context).add(
          LoginButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text,
          ),
        );
      }
    }

    Widget oneColumnLayout(LoginState state) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(25.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/app_logo_design.png',
                height: 180.0,
              ),
              Text(
                'triige',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.0),
              Text(
                'Patient Triage Tracking System',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      fillColor: Theme.of(context).primaryColor,
                      hasFloatingPlaceholder: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: cyan, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.0),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Theme.of(context).primaryColor,
                      hasFloatingPlaceholder: true,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: cyan, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: RaisedButton(
                  splashColor: Theme.of(context).accentColor,
                  padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        color: white,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () async {
                    state is! LoginLoading ? _onLoginButtonPressed() : null;
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child:
                    state is LoginLoading ? CircularProgressIndicator() : null,
              ),
            ],
          ),
        ),
      );
    }

    Widget twoColumnLayout(LoginState state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(
                'assets/login_bg.jpg',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: oneColumnLayout(state),
            ),
          ),
        ],
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return isMobile(context)
              ? oneColumnLayout(state)
              : twoColumnLayout(state);
        },
      ),
    );
  }
}

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
