import 'package:flutter/material.dart';
import 'package:movieapp/extensions.dart';

import '../constants.dart';

class SortView extends StatefulWidget {
  final String sorting;
  final Function(String)? callback;
  const SortView(this.sorting, {Key? key, this.callback}) : super(key: key);

  @override
  State<SortView> createState() => _SortViewState();
}

class _SortViewState extends State<SortView> {
  late String sorting;
  var sortings = const [
    {"id": "title", "text": "By title: A to Z"},
    {"id": "-title", "text": "By title: Z to A"},
    {"id": "-created_at", "text": "By date: From new to old"},
    {"id": "created_at", "text": "By date: From old to new"},
    {"id": "rating", "text": "By rating: From top to bottom"},
    {"id": "-rating", "text": "By rating: From bottom to top"},
  ];

  @override
  initState() {
    super.initState();
    sorting = widget.sorting;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Padding(
        padding: EdgeInsets.only(bottom: context.mediaQuery.viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  width: 72,
                  height: 5,
                  color: basic300,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Sort".tr,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) => sortViewItem(sortings[index]),
                  separatorBuilder: (ctx, index) => const Divider(
                        height: 0,
                      ),
                  itemCount: sortings.length),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.callback != null)
                    TextButton(
                        style: applyButtonStyle,
                        onPressed: () {
                          context.back();
                          widget.callback!(sorting);
                        },
                        child: Text(
                          "APPLY".tr,
                          style: const TextStyle(fontSize: 18),
                        )),
                  TextButton(
                      onPressed: context.back,
                      child: Text(
                        "CANCEL".tr,
                        style: const TextStyle(fontSize: 18),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sortViewItem(Map<String, String> item) {
    var id = item["id"]!;
    var text = item["text"]!;
    return ListTile(
        onTap: () => setState(() {
              sorting = id;
            }),
        leading: Radio(
            value: id,
            groupValue: sorting,
            onChanged: (String? value) {
              if (widget.callback != null) {
                widget.callback!(value!);
              }
            }),
        title: Text(
          text.tr,
          style: TextStyle(
            fontWeight:
                id == widget.sorting ? FontWeight.bold : FontWeight.normal,
          ),
        ));
  }
}
