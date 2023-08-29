import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muonroi/features/Stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/Stories/data/repositories/story_repository.dart';
part 'story_event.dart';
part 'story_state.dart';

class StoryDataHomePageBloc extends Bloc<StoryEvent, StoryState> {
  final int pageIndex;
  final int pageSize;
  StoryDataHomePageBloc(this.pageIndex, this.pageSize) : super(StoryInitial()) {
    final StoryRepository storyRepository = StoryRepository();
    on<GetStoriesList>((event, emit) async {
      try {
        emit(StoryLoadingState());
        final mList =
            await storyRepository.fetchStoriesData(pageIndex, pageSize);
        emit(StoryLoadedState(mList));
        if (!mList.isOk) {
          emit(StoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const StoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
