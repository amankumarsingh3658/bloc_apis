import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvents {
  String email;
  EmailChanged({required this.email});
  @override
  List<Object?> get props => [email];
  
}
class PasswordChanged extends LoginEvents {
  String password;
  PasswordChanged({required this.password});
  @override
  List<Object?> get props => [password];
  
}

class LoginApi extends LoginEvents {
  
}