part of 'view_single_bloc.dart';

abstract class ViewSingleState extends Equatable {
  const ViewSingleState();

  @override
  List<Object> get props => [];
}

final class ViewSingleInitial extends ViewSingleState {}

class ViewSingleLoadingState extends ViewSingleState {}

class ViewSingleLoadedState extends ViewSingleState {
  final bool stateView;
  const ViewSingleLoadedState(this.stateView);
}

class ViewSingleErrorState extends ViewSingleState {
  final String error;
  const ViewSingleErrorState(this.error);
}
