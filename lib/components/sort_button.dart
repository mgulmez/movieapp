import 'package:flutter/material.dart';
import 'package:movieapp/extensions.dart';

import '../constants.dart';
import '../views/sort_view.dart';

class SortButton extends StatelessWidget {
  static var buttonBgColor = const Color(0xffE9E9E9);
  static var buttonBorderColor = const Color(0xffDFDFDF);
  final String sorting;
  final Function(String)? callback;
  SortButton({Key? key, required this.sorting, this.callback})
      : super(key: key);

  final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: BorderSide(color: buttonBorderColor));

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        heroTag: "sort",
        onPressed: () => context.bottomSheet(
          SortView(
            sorting,
            callback: callback,
          ),
          isDismissible: true,
        ),
        label: Text(
          "Sort".tr,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        icon: iconSort(),
        backgroundColor: buttonBgColor,
        elevation: 0,
        shape: shape,
      );
}
