part of 'banner_bloc.dart';

sealed class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

class GetBannerList extends BannerEvent {
  const GetBannerList();
}
