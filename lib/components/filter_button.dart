import 'package:flutter/material.dart';
import 'package:movieapp/extensions.dart';
import '../constants.dart';

// ignore: must_be_immutable
class FilterButton extends StatelessWidget {
  static var buttonBgColor = const Color(0xffE9E9E9);
  static var buttonBorderColor = const Color(0xffDFDFDF);
  final Widget child;
  FilterButton({Key? key, required this.child}) : super(key: key);

  var shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: BorderSide(color: buttonBorderColor));

  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        heroTag: "filter",
        onPressed: () => context.bottomSheet(
          child,
        ),
        label: Text(
          "Filter".tr,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        icon: iconFilter(),
        backgroundColor: buttonBgColor,
        elevation: 0,
        shape: shape,
      );
}
