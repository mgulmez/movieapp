import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/extensions.dart';
import 'package:movieapp/pages/favorites.dart';
import 'package:movieapp/pages/search.dart';
import 'package:movieapp/views/error_view.dart';
import 'package:movieapp/views/no_items_view.dart';

import '../blocs/movie_bloc.dart';
import '../blocs/theme.dart';
import '../common/bloc_state.dart';
import '../views/movie_list_view.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies".tr),
        actions: [
          IconButton(
              onPressed: () => context.push(const FavoritesPage()),
              icon: const Icon(Icons.favorite)),
          IconButton(
              onPressed: () => context.push(const SearchPage()),
              icon: const Icon(Icons.search)),
          BlocBuilder<ThemeBLOC, ThemeMode>(builder: (context, mode) {
            return Switch(
                value: context.themeBLOC.state == ThemeMode.light,
                onChanged: (value) => context.themeBLOC.toggle());
          })
        ],
      ),
      body: BlocBuilder<MovieBLOC, BlocState>(builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorState) {
          return ErrorView(state);
        } else if (state is MovieListState) {
          return state.movies.isEmpty
              ? const NoItemsView()
              : MovieListView(state.movies);
        }
        return Container();
      }),
    );
  }
}
