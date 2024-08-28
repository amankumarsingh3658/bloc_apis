import 'package:bloc/bloc.dart';
import 'package:bloc_apis/Bloc/PostBloc/post_events.dart';
import 'package:bloc_apis/Bloc/PostBloc/post_state.dart';
import 'package:bloc_apis/Models/post_model.dart';
import 'package:bloc_apis/Repository/post_repository.dart';
import 'package:bloc_apis/Utils/enums.dart';

class PostsBloc extends Bloc<PostEvents, PostState> {
  PostRepository postRepo = PostRepository();
  List<PostModel> tempPostList = [];
  PostsBloc() : super(PostState()) {
    on<PostFetched>(fetchPosts);
    on<SearchPost>(_searchPost);
  }

  void fetchPosts(PostFetched event, Emitter<PostState> emit) async {
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

  void _searchPost(SearchPost event, Emitter<PostState> emit) {
    if (event.search.isEmpty) {
      emit(state.copyWith(tempSearchList: [], searchMessage: ''));
    } else {
      tempPostList = state.postList
          .where((element) => element.email
              .toString()
              .toLowerCase()
              .contains(event.search.toString().toLowerCase()))
          .toList();
      // tempPostList = state.postList
      //     .where((element) => element.id.toString() == event.search.toString())
      //     .toList();
      if (tempPostList.isEmpty) {
        emit(
            state.copyWith(tempSearchList: [], searchMessage: 'No Data Found'));
      } else {
        emit(state.copyWith(tempSearchList: tempPostList, searchMessage: ''));
      }
    }
  }
}
