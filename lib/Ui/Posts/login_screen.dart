import 'package:bloc_apis/Bloc/LoginBloc/login_bloc.dart';
import 'package:bloc_apis/Bloc/LoginBloc/login_events.dart';
import 'package:bloc_apis/Bloc/LoginBloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: BlocProvider(
          create: (_) => LoginBloc(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      current.email != previous.email,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(EmailChanged(email: value));
                      },
                      onFieldSubmitted: (value) {},
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      current.password != previous.password,
                  builder: (context, state) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onChanged: (value) {
                        context
                            .read<LoginBloc>()
                            .add(PasswordChanged(password: value));
                      },
                      onFieldSubmitted: (value) {},
                    );
                  },
                ),
                BlocListener<LoginBloc, LoginState>(
                  listenWhen: (previous, current) => current.loginStatus != previous.loginStatus,
                  listener: (context, state) {
                    if (state.loginStatus == LoginStatus.error) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text(state.message.toString())));
                    }
                    else if (state.loginStatus == LoginStatus.loading) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text('Submitting')));
                    }
                    else if (state.loginStatus == LoginStatus.success) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text('Success')));
                    }
                    
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(LoginApi());
                          },
                          child: Text("Login"));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
