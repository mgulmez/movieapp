import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_filter.dart';

class RatingSelectView extends StatefulWidget {
  final MovieFilter filter;
  const RatingSelectView(this.filter, {Key? key}) : super(key: key);

  @override
  State<RatingSelectView> createState() => _RatingSelectViewState();
}

class _RatingSelectViewState extends State<RatingSelectView> {
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
        maxHeight: 250,
      ),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (ctx, index) => ratingItem(9 - index),
          separatorBuilder: (ctx, index) => const Divider(
                height: 0,
              ),
          itemCount: 5),
    );
  }

  Widget ratingItem(int rate) {
    var checked = filter.rating == rate;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Checkbox(
        value: checked,
        onChanged: (value) => toggleRating(rate),
      ),
      title: Text(
        "$rate+",
        style: TextStyle(
            fontWeight: checked ? FontWeight.bold : FontWeight.normal),
      ),
      onTap: () => toggleRating(rate),
    );
  }

  void toggleRating(int rating) {
    setState(() {
      filter.rating = rating;
    });
  }
}
