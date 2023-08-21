part of 'categories_all_bloc.dart';

@immutable
abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
  @override
  List<Object?> get props => [];
}

class GetCategoriesEventList extends CategoriesEvent {}
