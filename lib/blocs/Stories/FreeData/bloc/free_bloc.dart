import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/Enums/enum.search.story.dart';
import 'package:muonroi/repository/Story/story_repository.dart';
part 'free_event.dart';
part 'free_state.dart';

class FreeStoryPageBloc extends Bloc<FreeStoryEvent, FreeStoryState> {
  late int pageIndex;
  final int pageSize;
  FreeStoryPageBloc(this.pageIndex, this.pageSize)
      : super(FreeStoryInitialState()) {
    final StoryRepository storyRepository = StoryRepository();
    on<GetFreeStoriesList>((event, emit) async {
      try {
        emit(FreeStoryLoadingState());
        final mList =
            await storyRepository.fetchStoriesData(pageIndex, pageSize);
        emit(FreeStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(FreeStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const FreeStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
    on<GroupMoreFreeStoryList>((event, emit) async {
      try {
        emit(FreeStoryLoadingState());
        pageIndex++;
        late StoriesModel mList;
        if (event.categoryId == 0) {
          mList = await storyRepository.fetchStoriesData(pageIndex, pageSize);
        } else {
          mList = await storyRepository.searchStory(
              [event.categoryId.toString()],
              [SearchType.category],
              pageIndex,
              pageSize);
        }
        emit(FreeStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(FreeStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const FreeStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
