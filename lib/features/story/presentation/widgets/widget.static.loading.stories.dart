import 'package:flutter/material.dart';
import 'package:muonroi/features/story/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class LoadingStoriesHome extends StatefulWidget {
  final double? height, width;

  const LoadingStoriesHome({Key? key, this.height, this.width})
      : super(key: key);

  @override
  State<LoadingStoriesHome> createState() => _LoadingStoriesHomeState();
}

class _LoadingStoriesHomeState extends State<LoadingStoriesHome>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacityTween = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityTween,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityTween.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            height: widget.height,
            width: widget.width,
            padding: const EdgeInsets.all(defaultPadding / 2),
            decoration: BoxDecoration(
              color: themeMode(context, ColorCode.loadingContainerColor.name),
              borderRadius: const BorderRadius.all(
                Radius.circular(defaultPadding),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}
