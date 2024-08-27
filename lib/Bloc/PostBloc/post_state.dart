import 'package:bloc_apis/Models/post_model.dart';
import 'package:bloc_apis/Utils/enums.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> postList;
  final String message;
  PostState(
      {this.postStatus = PostStatus.Loading,
      this.postList = const [],
      this.message = ''});

  PostState copyWith(
      {PostStatus? postStatus, List<PostModel>? postList, String? message}) {
    return PostState(
        postStatus: postStatus ?? this.postStatus,
        postList: postList ?? this.postList,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [postStatus, postList, message];
}
