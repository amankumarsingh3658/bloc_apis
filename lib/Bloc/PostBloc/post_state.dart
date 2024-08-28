import 'package:bloc_apis/Models/post_model.dart';
import 'package:bloc_apis/Utils/enums.dart';
import 'package:equatable/equatable.dart';

class PostState extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> postList;
  final String message;
  final String searchMessage;
  final List<PostModel> tempSearchList;
  PostState(
      {this.postStatus = PostStatus.Loading,
      this.postList = const [],
      this.message = '',
      this.tempSearchList = const [],
      this.searchMessage = ''});

  PostState copyWith(
      {PostStatus? postStatus,
      List<PostModel>? postList,
      String? message,
      List<PostModel>? tempSearchList,
      String? searchMessage}) {
    return PostState(
        postStatus: postStatus ?? this.postStatus,
        postList: postList ?? this.postList,
        message: message ?? this.message,
        tempSearchList: tempSearchList ?? this.tempSearchList,
        searchMessage: searchMessage ?? this.searchMessage);
  }

  @override
  List<Object?> get props =>
      [postStatus, postList, message, tempSearchList, searchMessage];
}
