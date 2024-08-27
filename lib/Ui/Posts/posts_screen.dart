import 'package:bloc_apis/Bloc/PostBloc/post_events.dart';
import 'package:bloc_apis/Bloc/PostBloc/post_state.dart';
import 'package:bloc_apis/Bloc/PostBloc/posts_bloc.dart';
import 'package:bloc_apis/Utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostsBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Api"),
      ),
      body: BlocBuilder<PostsBloc, PostState>(builder: (context, state) {
        // print(state.postStatus);
        switch (state.postStatus) {
          case PostStatus.Loading:
            print(state.postStatus);
            return Center(child: CircularProgressIndicator());
          case PostStatus.Success:
            print(state.postStatus);
            print(state.postList);
            return ListView.builder(
                itemCount: state.postList.length,
                itemBuilder: (context, index) {
                  final item = state.postList[index];
                  return ListTile(
                    trailing: Text(item.email.toString()),
                    leading: Text(item.id.toString()),
                    title: Text(
                      item.name.toString(),
                    ),
                    subtitle: Text(item.body.toString()),
                  );
                });
          case PostStatus.Failure:
            print(state.postStatus);
            return Center(child: Text(state.message.toString()));
        }
      }),
    );
  }
}
