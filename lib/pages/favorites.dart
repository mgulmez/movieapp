import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/blocs/favorites_bloc.dart';
import 'package:movieapp/extensions.dart';

import '../common/bloc_state.dart';
import '../views/movie_list_view.dart';
import '../views/no_items_view.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key = const Key("favorites")}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites".tr),
      ),
      body: BlocBuilder<FavoritesBLOC, BlocState>(builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavoriesState) {
          return state.movies.isEmpty
              ? const NoItemsView()
              : MovieListView(
                  state.movies,
                  showFilters: false,
                );
        }
        return Container();
      }),
    );
  }
}
