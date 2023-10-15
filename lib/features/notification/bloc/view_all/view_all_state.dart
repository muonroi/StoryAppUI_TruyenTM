part of 'view_all_bloc.dart';

abstract class ViewAllState extends Equatable {
  const ViewAllState();

  @override
  List<Object> get props => [];
}

final class ViewAllInitial extends ViewAllState {}

class ViewAllLoadingState extends ViewAllState {}

class ViewAllLoadedState extends ViewAllState {
  final bool stateView;
  const ViewAllLoadedState(this.stateView);
}

class ViewAllErrorState extends ViewAllState {
  final String error;
  const ViewAllErrorState(this.error);
}
