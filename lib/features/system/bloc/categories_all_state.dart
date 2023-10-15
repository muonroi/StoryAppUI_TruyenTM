part of 'categories_all_bloc.dart';

@immutable
abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final CategoriesModel categories;
  const CategoriesLoadedState(this.categories);
}

class CategoriesErrorState extends CategoriesState {
  final String error;
  const CategoriesErrorState(this.error);
}
