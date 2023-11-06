import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/story/data/models/enum/enum.story.user.dart';
import 'package:muonroi/features/story/data/models/models.stories.story.dart';
import 'package:muonroi/features/story/data/repositories/story_repository.dart';

part 'stories_for_user_event.dart';
part 'stories_for_user_state.dart';

class StoriesForUserBloc
    extends Bloc<StoriesForUserEvent, StoriesForUserState> {
  late int pageIndex;
  final int pageSize;
  final StoryForUserType storyForUserType;
  StoriesForUserBloc(
      {required this.pageIndex,
      required this.pageSize,
      required this.storyForUserType})
      : super(StoriesForUserInitial()) {
    final storyRepository = StoryRepository();
    on<StoriesForUserList>((event, emit) async {
      try {
        emit(StoriesForUserLoadingState());
        if (event.isPrevious && !event.onRefresh) {
          pageIndex--;
        } else if (!event.isPrevious && pageIndex > 1 && !event.onRefresh) {
          pageIndex++;
        }
        pageIndex = pageIndex < 1 ? 1 : pageIndex;
        final mList = await storyRepository.getStoryForUser(
            storyForUserType.index, pageIndex, pageSize);
        emit(mList.result.items.isEmpty
            ? StoriesForUserNoDataState()
            : StoriesForUserLoadedState(mList));
        if (!mList.isOk) {
          emit(StoriesForUserErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const StoriesForUserErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
