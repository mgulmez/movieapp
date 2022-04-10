import 'package:flutter/material.dart';
import 'package:movieapp/extensions.dart';
import '../constants.dart';

class FilterView extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? backButton;
  final Function()? onApply;
  const FilterView(this.title, this.content,
      {this.onApply, this.backButton, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Padding(
        padding: EdgeInsets.only(bottom: context.mediaQuery.padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 72,
                        height: 5,
                        color: basic300,
                      ),
                    ),
                    Center(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    content,
                    if (onApply != null)
                      TextButton(
                          style: applyButtonStyle,
                          onPressed: () {
                            onApply!();
                            context.back();
                          },
                          child: Text("APPLY".tr)),
                    backButton ?? defaultBackButton(context)
                  ]).space(16),
            ),
          ],
        ),
      ),
    );
  }

  Widget defaultBackButton(BuildContext context) => TextButton.icon(
      onPressed: context.back,
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
      label: Text(
        "BACK TO FILTER".tr,
        style: const TextStyle(fontSize: 18),
      ));
}
