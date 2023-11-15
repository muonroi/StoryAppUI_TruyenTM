import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/homes/data/models/model.home.banner.dart';
import 'package:muonroi/features/homes/data/repository/home.repository.dart';
import 'package:muonroi/features/homes/settings/enum/enum.setting.type.dart';
part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final EnumSettingType type;
  BannerBloc(this.type) : super(BannerInitial()) {
    on<GetBannerList>((event, emit) async {
      final storyRepository = HomeRepository();
      try {
        emit(BannerLoadingState());
        final mList = await storyRepository.getBannerList(type.index);
        emit(BannerLoadedState(mList));
        if (!mList.isOk) {
          emit(BannerErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const BannerErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
