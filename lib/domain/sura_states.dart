abstract class SuraState {}

class SuraInitial extends SuraState {}

class SuraLoading extends SuraState {}

class SuraLoaded extends SuraState {
  final String content;
  SuraLoaded(this.content);
}

class SuraError extends SuraState {
  final String message;
  SuraError(this.message);
}