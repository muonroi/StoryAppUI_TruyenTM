part of 'view_all_bloc.dart';

abstract class ViewAllEvent extends Equatable {
  const ViewAllEvent();

  @override
  List<Object> get props => [];
}

class ActionAllEvent extends ViewAllEvent {}
