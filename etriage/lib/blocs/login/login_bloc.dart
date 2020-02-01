import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:etriage/models/user.dart';
import 'package:meta/meta.dart';

import '../auth/authentication.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final User user;
  final AuthenticationBloc authenticationBloc;
  static String userName;

  LoginBloc({
    @required this.user,
    @required this.authenticationBloc,
  })  : assert(user != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        userName = event.username;
        final token = await user.authenticate(
          username: event.username,
          password: event.password,
        );
        if (token != null) {
          authenticationBloc.add(LoggedIn(token: token));
          yield LoginInitial();
        } else {
          yield LoginFailure(error: 'Error: Incorrect username or password!');
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
