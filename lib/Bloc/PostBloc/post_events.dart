import 'package:equatable/equatable.dart';

abstract class PostEvents extends Equatable {
  // PostEvents();
  @override
  List<Object?> get props => [];
}

class PostFetched extends PostEvents {
  
}

class SearchPost extends PostEvents {
  final String search;
  SearchPost(this.search);

  @override
  // TODO: implement props
  List<Object?> get props => [search];
}
