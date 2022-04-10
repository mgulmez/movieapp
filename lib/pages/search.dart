import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/api.dart';
import 'package:movieapp/extensions.dart';
import 'package:movieapp/models/movie_filter.dart';
import 'package:movieapp/storage.dart';

import '../blocs/movie_bloc.dart';
import '../common/app_state.dart';
import '../common/bloc_state.dart';
import '../views/error_view.dart';
import '../views/movie_list_view.dart';
import '../views/no_items_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends AppState<SearchPage> {
  TextEditingController searchController = TextEditingController(text: '');

  final MovieBLOC bloc = MovieBLOC(OmdbApi())
    ..add(GetMoviesEvent(MovieFilter()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search".tr),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                keyboardType: TextInputType.text,
                validator: (value) =>
                    value.validateText(errorMessage: 'Please type a word'.tr),
                decoration: InputDecoration(
                    labelText: "SEARCH".tr,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffix: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => search(searchController.text),
                      icon: const Icon(Icons.search),
                    )),
              ),
            ),
            Wrap(
              children: [
                ...Storage.instance.searchHistory.map((e) => GestureDetector(
                      onTap: () => searchController.text = e,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: context.theme.hintColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e),
                            )),
                      ),
                    ))
              ],
            ),
            Expanded(
              child:
                  BlocBuilder<MovieBLOC, BlocState>(builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return BlocBuilder<MovieBLOC, BlocState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ErrorState) {
                        return ErrorView(state);
                      } else if (state is MovieListState) {
                        return state.movies.isEmpty
                            ? const NoItemsView()
                            : MovieListView(
                                state.movies,
                                showFilters: false,
                              );
                      }
                      return Container();
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }

  void search(String text) {
    if (formKey.currentState?.validate() ?? false) {
      bloc.add(GetMoviesEvent(bloc.lastFilter.copyWith(search: text)));
    }
  }
}
