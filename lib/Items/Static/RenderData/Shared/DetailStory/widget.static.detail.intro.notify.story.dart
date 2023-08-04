import 'package:flutter/material.dart';
import 'package:muonroi/Settings/settings.fonts.dart';

class IntroAndNotificationStory extends StatelessWidget {
  final String name;
  final String value;
  const IntroAndNotificationStory(
      {super.key, required this.name, required this.value});

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
                  name,
                  style: FontsDefault.h4,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  value,
                  maxLines: 5,
                  overflow: TextOverflow.fade,
                  style: FontsDefault.h5,
                ),
              ),
            ],
          ),
          SizedBox(
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_down)),
          )
        ],
      ),
    );
  }
}
