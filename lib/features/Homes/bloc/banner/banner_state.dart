part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

final class BannerInitial extends BannerState {}

class BannerLoadingState extends BannerState {}

class BannerLoadedState extends BannerState {
  final ModelBannerResponse banners;
  const BannerLoadedState(this.banners);
}

class BannerErrorState extends BannerState {
  final String error;
  const BannerErrorState(this.error);
}
