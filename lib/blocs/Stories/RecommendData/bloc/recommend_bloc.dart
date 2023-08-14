import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/repository/Story/story_repository.dart';
part 'recommend_event.dart';
part 'recommend_state.dart';

class RecommendStoryPageBloc
    extends Bloc<RecommendStoryEvent, RecommendStoryState> {
  final int storyId;
  RecommendStoryPageBloc(this.storyId) : super(RecommendStoryInitialState()) {
    final StoryRepository storyRepository = StoryRepository();
    on<GetRecommendStoriesList>((event, emit) async {
      try {
        emit(RecommendStoryLoadingState());
        final mList = await storyRepository.fetchRecommendStories(storyId);
        emit(RecommendStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(RecommendStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const RecommendStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
