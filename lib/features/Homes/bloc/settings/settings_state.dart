part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsLoadedState extends SettingsState {
  final ModelSettingResponse settings;
  const SettingsLoadedState(this.settings);
}

class SettingsErrorState extends SettingsState {
  final String error;
  const SettingsErrorState(this.error);
}
