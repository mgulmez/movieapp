import 'package:flutter/material.dart';
import 'package:movieapp/extensions.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../constants.dart';

class NoItemsView extends StatelessWidget {
  const NoItemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              iconSearch(size: 36),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "There is no data".tr,
                      style: const TextStyle(fontSize: 24),
                    ),
                    HTML.toRichText(context, "Please check here later".tr,
                        defaultTextStyle: context.theme.textTheme.bodyText2!
                            .copyWith(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                  ]).space(16)
            ],
          ).space(48),
        )
      ],
    );
  }
}
