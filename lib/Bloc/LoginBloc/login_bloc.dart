import 'dart:convert';

import 'package:bloc_apis/Bloc/LoginBloc/login_events.dart';
import 'package:bloc_apis/Bloc/LoginBloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_loginApi);
  }
  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    var credentials = {'email': state.email, 'password': state.password};

    try {
      final response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: credentials);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(state.copyWith(
          loginStatus: LoginStatus.success,
          message: 'Login Successful',
        ));
      } else {
        emit(state.copyWith(
            loginStatus: LoginStatus.error, message: data['error']));
      }
    } catch (e) {
      emit(state.copyWith(
          loginStatus: LoginStatus.error, message: e.toString()));
    }
  }
}
