part of 'bloc_bloc.dart';

@immutable
abstract class BlocEvent {}

class GetNextItems extends BlocEvent {
  final PageId pageId;
  final int pageNo;

  GetNextItems({
    @required this.pageId,
    @required this.pageNo,
  });
}

class GetPrices extends BlocEvent {}

class Query extends BlocEvent {}

class SubmitNewPost extends BlocEvent {}

class GetCategories extends BlocEvent {
  final PageId pageId;

  GetCategories({
    @required this.pageId,
  });
}

class GetEditPostContent extends BlocEvent {}

class LogIn extends BlocEvent {}

class LogInWithGoogle extends BlocEvent {}

class CreateAccount extends BlocEvent {}

class AddComment extends BlocEvent {}

class GetArticalContent extends BlocEvent {
  final PageId pageId;
  GetArticalContent({
    @required this.pageId,
  });
}
