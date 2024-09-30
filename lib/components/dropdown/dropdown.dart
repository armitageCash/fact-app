import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class Dropdown<T> extends StatelessWidget {
  final String hintText;
  final String? searchHintText;
  final List<T> items;
  final bool? allowSearch;
  final void Function(T?)? onChanged;

  const Dropdown({
    Key? key,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.allowSearch,
    this.searchHintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return allowSearch != null && allowSearch!
        ? CustomDropdown<T>.search(
            hintText: hintText,
            searchHintText: searchHintText ?? '',
            items: items,
            onChanged: onChanged,
          )
        : CustomDropdown<T>(
            hintText: hintText,
            items: items,
            onChanged: onChanged,
          );
  }
}
