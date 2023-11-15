import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muonroi/features/story/data/models/model.stories.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
part 'recommend_event.dart';
part 'recommend_state.dart';

class RecommendStoryPageBloc
    extends Bloc<RecommendStoryEvent, RecommendStoryState> {
  final int storyId;
  final int pageIndex;
  final int pageSize;
  RecommendStoryPageBloc(this.storyId, this.pageIndex, this.pageSize)
      : super(RecommendStoryInitialState()) {
    final StoryRepository storyRepository = StoryRepository();
    on<GetRecommendStoriesList>((event, emit) async {
      try {
        emit(RecommendStoryLoadingState());
        final mList = await storyRepository.fetchRecommendStories(
            storyId, pageIndex, pageSize);
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
