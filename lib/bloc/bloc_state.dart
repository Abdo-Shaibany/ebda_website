part of 'bloc_bloc.dart';

@immutable
abstract class BlocState {}

class BlocInitial extends BlocState {}

class Loading extends BlocState {
  final PageId pageId;

  Loading({
    @required this.pageId,
  });
}

class Ok extends BlocState {
  final PageId pageId;

  Ok({
    @required this.pageId,
  });
}

class Error extends BlocState {
  final PageId pageId;

  Error({
    @required this.pageId,
  });
}
