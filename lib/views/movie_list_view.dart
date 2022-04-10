import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/blocs/favorites_bloc.dart';
import 'package:movieapp/blocs/movie_bloc.dart';
import 'package:movieapp/extensions.dart';
import 'package:movieapp/views/movie_filter_view.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../common/bloc_state.dart';
import '../components/filter_button.dart';
import '../components/sort_button.dart';
import '../models/movie.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> list;
  final bool showFilters;
  const MovieListView(this.list, {Key? key, this.showFilters = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoritesBloc = context.favoritesBLOC;
    return Column(
      children: [
        if (showFilters)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: sortAndFieldRow(context),
          ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(4),
            shrinkWrap: true,
            children: [...list.map((e) => movie(context, favoritesBloc, e))],
          ),
        ),
      ],
    );
  }

  Widget sortAndFieldRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: HTML.toRichText(context,
                "<b>%s</b> movies found".trArgs([list.length.toString()]),
                defaultTextStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: context.textTheme.bodyText1?.color))),
        SortButton(
          sorting: context.movieBLOC.lastFilter.sorting,
          callback: (sorting) => context.movieBLOC.add(GetMoviesEvent(
              context.movieBLOC.lastFilter.copyWith(sorting: sorting))),
        ),
        FilterButton(child: MovieFilterView(context.movieBLOC.lastFilter))
      ],
    ).space(16);
  }

  Widget movie(BuildContext context, FavoritesBLOC favoritesBLOC, Movie movie) {
    return BlocBuilder<FavoritesBLOC, BlocState>(
        bloc: favoritesBLOC,
        builder: (context, mode) {
          var addedToFavories =
              favoritesBLOC.favorites.any((e) => e.imdbId == movie.imdbId);
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.network(
                    movie.poster,
                    fit: BoxFit.cover,
                  )),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: Icon(addedToFavories
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: () async {
                          if (addedToFavories) {
                            var confirmToDelete = await context.showAlertDialog<
                                    bool>(
                                'Remove From Favorites'.tr,
                                'Do you want to remove %s from your favorites?'
                                    .trArgs([movie.title]),
                                [
                                  TextButton(
                                      onPressed: () => context.back(true),
                                      child: Text("Yes".tr)),
                                  TextButton(
                                      onPressed: () => context.back(false),
                                      child: Text("No".tr))
                                ]);
                            if (confirmToDelete ?? false) {
                              favoritesBLOC.add(RemoveFromFavoriesEvent(movie));
                            }
                          } else {
                            favoritesBLOC.add(AddToFavoriesEvent(movie));
                          }
                        },
                      ))
                ],
              ),
            ),
          );
        });
  }
}
