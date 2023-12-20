import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/homes/data/models/model.setting.dart';
import 'package:muonroi/features/homes/data/repository/home.repository.dart';
import 'package:muonroi/features/homes/settings/enum/enum.setting.type.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final EnumSettingType type;
  SettingsBloc(this.type) : super(SettingsInitial()) {
    on<GetSettingList>((event, emit) async {
      final storyRepository = HomeRepository();
      try {
        emit(SettingsLoadingState());
        final mList = await storyRepository.getSettingByType(type.index);
        emit(SettingsLoadedState(mList));
        if (!mList.isOk) {
          emit(SettingsErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const SettingsErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
