import 'package:flutter/material.dart';
import 'package:muonroi/Settings/settings.fonts.dart';

class IntroAndNotificationStory extends StatefulWidget {
  final String name;
  final String value;
  const IntroAndNotificationStory(
      {super.key, required this.name, required this.value});

  @override
  State<IntroAndNotificationStory> createState() =>
      _IntroAndNotificationStoryState();
}

class _IntroAndNotificationStoryState extends State<IntroAndNotificationStory>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    animationReadMoreController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    animationReadMoreController.dispose();
    super.dispose();
  }

  int sizeMore = 100;
  late AnimationController animationReadMoreController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  widget.name,
                  style: FontsDefault.h4,
                ),
              ),
              Container(
                height: sizeMore * 1.0,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  widget.value,
                  maxLines: 5,
                  overflow: TextOverflow.fade,
                  style: FontsDefault.h5,
                ),
              ),
            ],
          ),
          SizedBox(
            child: RotationTransition(
              turns: Tween(
                begin: 0.0,
                end: 0.5,
              ).animate(animationReadMoreController),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (animationReadMoreController.value == 1) {
                        sizeMore = 100;
                        animationReadMoreController.reverse(from: 0.0);
                      } else {
                        sizeMore = sizeMore * 2;
                        animationReadMoreController.forward(from: 0.5);
                      }
                    });
                  },
                  icon: const Icon(Icons.keyboard_arrow_down)),
            ),
          ),
        ],
      ),
    );
  }
}
