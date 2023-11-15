import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/story/data/models/model.stories.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.common.dart';
part 'common_stories_event.dart';
part 'common_stories_state.dart';

class CommonStoriesBloc extends Bloc<CommonStoriesEvent, CommonStoriesState> {
  late int pageIndex;
  final int pageSize;
  final EnumStoriesCommon type;
  CommonStoriesBloc(this.pageIndex, this.pageSize, this.type)
      : super(CommonStoriesInitial()) {
    final storyRepository = StoryRepository();
    on<GetCommonStoriesList>((event, emit) async {
      try {
        emit(CommonStoriesLoadingState());
        if (event.isPrevious && !event.onRefresh) {
          pageIndex--;
        } else if (!event.isPrevious && pageIndex >= 1 && !event.onRefresh) {
          pageIndex++;
        }
        pageIndex = pageIndex < 1 ? 1 : pageIndex;
        final mList = await storyRepository.getStoryCommon(
            type.index, pageIndex, pageSize);
        emit(mList.result.items.isNotEmpty
            ? CommonStoriesLoadedState(mList)
            : CommonStoriesNoDataState());
        if (!mList.isOk) {
          emit(CommonStoriesErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const CommonStoriesErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
