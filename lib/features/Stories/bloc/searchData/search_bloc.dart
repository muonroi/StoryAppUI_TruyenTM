import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/shared/settings/enums/enum.search.story.dart';
import 'package:muonroi/features/stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/stories/data/repositories/story_repository.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchStoryEvent, SearchStoryState> {
  final List<String> keySearch;
  final List<SearchType> type;
  final int pageIndex;
  final int pageSize;
  SearchBloc(this.keySearch, this.pageIndex, this.pageSize, this.type)
      : super(SearchStoryInitialState()) {
    final StoryRepository storyRepository = StoryRepository();
    on<SearchStoriesList>((event, emit) async {
      try {
        emit(SearchStoryLoadingState());
        final mList = await storyRepository.searchStory(keySearch, type, 1, 10);
        emit(SearchStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(SearchStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const SearchStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
