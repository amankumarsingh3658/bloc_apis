import 'package:bloc/bloc.dart';
import 'package:bloc_apis/Bloc/PostBloc/post_events.dart';
import 'package:bloc_apis/Bloc/PostBloc/post_state.dart';
import 'package:bloc_apis/Repository/post_repository.dart';
import 'package:bloc_apis/Utils/enums.dart';

class PostsBloc extends Bloc<PostEvents, PostState> {
  PostRepository postRepo = PostRepository();
  PostsBloc() : super(PostState()) {
    on<PostFetched>(fetchPosts);
  }

  Future fetchPosts(PostFetched event, Emitter<PostState> emit) async {
    await postRepo.fetchPost().then((value) {
      emit(state.copyWith(
          postList: List.from(value),
          postStatus: PostStatus.Success,
          message: "Success"));
      // print(value);
    }).onError((error, StackTrace) {
      emit(state.copyWith(
          postStatus: PostStatus.Failure, message: error.toString()));
    });
  }
}
