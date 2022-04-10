import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_filter.dart';

class YearSelectView extends StatefulWidget {
  final MovieFilter filter;
  const YearSelectView(this.filter, {Key? key}) : super(key: key);

  @override
  State<YearSelectView> createState() => _YearSelectViewState();
}

class _YearSelectViewState extends State<YearSelectView> {
  late MovieFilter filter;
  @override
  void initState() {
    filter = widget.filter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (ctx, index) => storeItem(DateTime.now().year - index),
          separatorBuilder: (ctx, index) => const Divider(
                height: 0,
              ),
          itemCount: 50),
    );
  }

  Widget storeItem(int year) {
    var checked = filter.year == year;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Checkbox(
        value: checked,
        onChanged: (value) => toggleYear(year),
      ),
      title: Text(
        year.toString(),
        style: TextStyle(
            fontWeight: checked ? FontWeight.bold : FontWeight.normal),
      ),
      onTap: () => toggleYear(year),
    );
  }

  void toggleYear(int year) {
    setState(() {
      filter.year = year;
    });
  }
}
