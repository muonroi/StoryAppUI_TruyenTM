import 'package:flutter/material.dart';
import '../../../Settings/settings.language_code.vi..dart';
import '../../../Settings/settings.main.dart';

class SearchContainer extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onChanged;
  final bool isShowClearText;
  final double? sizeBar;
  const SearchContainer(
      {super.key,
      required this.searchController,
      required this.onChanged,
      required this.isShowClearText,
      this.sizeBar});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: searchController,
        onChanged: onChanged,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8.0),
            hintMaxLines: 1,
            hintText: L(ViCode.searchTextInfo.toString()),
            suffixIcon: Visibility(
              visible: isShowClearText,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {},
              ),
            ),
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
