import 'package:flutter/cupertino.dart';

class RenderHomePage extends StatelessWidget {
  const RenderHomePage(
      {super.key,
      required this.scrollLayoutController,
      required this.componentOfHomePage});
  final ScrollController scrollLayoutController;
  final List<Widget> componentOfHomePage;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: scrollLayoutController,
        itemCount: componentOfHomePage.length,
        itemBuilder: ((context, index) {
          return Column(children: [
            componentOfHomePage[index],
          ]);
        }));
  }
}
