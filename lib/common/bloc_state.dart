abstract class BlocState {}

class InitialState extends BlocState {}

class LoadingState extends BlocState {}

class ErrorState extends BlocState {
  final String errorMessage;
  ErrorState(this.errorMessage);
}
