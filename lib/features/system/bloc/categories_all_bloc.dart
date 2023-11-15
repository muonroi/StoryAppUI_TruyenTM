import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/Categories/data/models/models.stories.dart';
import 'package:muonroi/features/categories/data/repositories/categories.repository.dart';

part 'categories_all_event.dart';
part 'categories_all_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final int pageIndex;
  final int pageSize;
  CategoriesBloc(this.pageIndex, this.pageSize) : super(CategoriesInitial()) {
    CategoriesRepository categoriesRepository =
        CategoriesRepository(pageIndex, pageSize);
    on<GetCategoriesEventList>((event, emit) async {
      try {
        emit(CategoriesLoadingState());
        final mList = await categoriesRepository.fetchCategoriesData();
        emit(CategoriesLoadedState(mList));
        if (!mList.isOk) {
          emit(CategoriesErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const CategoriesErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
