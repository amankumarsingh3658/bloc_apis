import 'package:bloc_apis/Bloc/PostBloc/posts_bloc.dart';
import 'package:bloc_apis/Repository/post_repository.dart';
import 'package:bloc_apis/Ui/Posts/login_screen.dart';
import 'package:bloc_apis/Ui/Posts/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
