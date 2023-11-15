import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/story/data/models/model.stories.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.special.dart';

part 'special_event.dart';
part 'special_state.dart';

class SpecialStoriesBloc
    extends Bloc<SpecialStoriesEvent, SpecialStoriesState> {
  late int pageIndex;
  final int pageSize;
  final EnumStoriesSpecial type;
  SpecialStoriesBloc(this.pageIndex, this.pageSize, this.type)
      : super(StoriesSpecialInitial()) {
    final storyRepository = StoryRepository();
    on<GetSpecialStoriesList>((event, emit) async {
      try {
        emit(SpecialStoriesLoadingState());
        if (event.isPrevious && !event.onRefresh) {
          pageIndex--;
        } else if (!event.isPrevious && pageIndex >= 1 && !event.onRefresh) {
          pageIndex++;
        }
        pageIndex = pageIndex < 1 ? 1 : pageIndex;
        final mList = await storyRepository.getStoriesByType(
            type.index, pageIndex, pageSize);
        emit(mList.result.items.isNotEmpty
            ? SpecialStoriesLoadedState(mList)
            : SpecialStoriesNoDataState());
        if (!mList.isOk) {
          emit(SpecialStoriesErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const SpecialStoriesErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
