import 'package:flutter/material.dart';
import 'package:movieapp/blocs/movie_bloc.dart';
import 'package:movieapp/extensions.dart';

import '../constants.dart';
import '../models/movie_filter.dart';
import 'filter_view.dart';
import 'rating_select_view.dart';
import 'year_select_view.dart';

class MovieFilterView extends StatefulWidget {
  final MovieFilter filter;
  const MovieFilterView(this.filter, {Key? key}) : super(key: key);

  @override
  State<MovieFilterView> createState() => _MovieFilterViewState();
}

class _MovieFilterViewState extends State<MovieFilterView> {
  late MovieFilter filter;
  @override
  void initState() {
    filter = widget.filter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250 + context.mediaQuery.padding.bottom,
      decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 72,
                  height: 5,
                  color: basic300,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 24,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "Filter".tr,
                        style: const TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  filterViewItem(context, "Year".tr, () async {
                    await context.bottomSheet<List<int>?>(
                      FilterView("Year".tr, YearSelectView(filter),
                          onApply: () {
                        setState(() {});
                      }),
                    );
                  }, text: filter.year?.toString() ?? ""),
                  filterViewItem(context, "Rating".tr, () async {
                    await context.bottomSheet<int?>(
                      FilterView("Rating".tr, RatingSelectView(filter),
                          onApply: () {
                        setState(() {});
                      }),
                    );
                  }, text: filter.rating != null ? "${filter.rating}+" : ""),
                ],
              ),
              TextButton(
                  style: applyButtonStyle,
                  onPressed: () {
                    context.movieBLOC.add(GetMoviesEvent(filter));
                    context.back();
                  },
                  child: Text("APPLY".tr)),
            ],
          )),
    );
  }

  Widget filterViewItem(
      BuildContext context, String title, VoidCallback callback,
      {int? count, String? text}) {
    return ListTile(
        onTap: callback,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (text != null && text.isNotEmpty)
              SizedBox(
                  width: context.width / 3,
                  child: Text(text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontWeight: FontWeight.normal))),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (count != null && count > 0)
              CircleAvatar(
                radius: 10,
                backgroundColor: basic1000,
                child: Text(
                  "$count",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              )
          ],
        ).space(8));
  }
}
