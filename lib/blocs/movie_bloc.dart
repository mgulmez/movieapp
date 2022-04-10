import 'package:movieapp/api.dart';
import 'package:movieapp/common/bloc_event.dart';
import 'package:bloc/bloc.dart';
import 'package:movieapp/storage.dart';

import '../common/bloc_state.dart';
import '../models/movie.dart';
import '../models/movie_filter.dart';

abstract class MovieEvent extends BlocEvent {}

abstract class MovieState extends BlocState {}

class GetMoviesEvent extends MovieEvent {
  final MovieFilter filter;
  GetMoviesEvent(this.filter);
}

class MovieListState extends MovieState {
  final List<Movie> movies;
  MovieListState(this.movies);
}

class MovieBLOC extends Bloc<MovieEvent, BlocState> {
  late MovieFilter lastFilter;
  final OmdbApi api;
  MovieBLOC(this.api) : super(InitialState()) {
    on<GetMoviesEvent>(_getMovies);
  }

  // omdb api sadece tek result dönüyor. sanırım apide değişiklik olmuş
  void _getMovies(GetMoviesEvent event, Emitter<BlocState> emit) async {
    emit(LoadingState());
    lastFilter = event.filter;
    if (lastFilter.search?.isNotEmpty ?? false) {
      Storage.instance.addToSearchHistory(lastFilter.search!);
    }
    List<Movie> list = [];
    var url = '?plot=short&r=json&p=${event.filter.page}';
    if (event.filter.search != null) {
      url += '&t=${event.filter.search}';
    }
    if (event.filter.year != null) {
      url += '&y=${event.filter.year}';
    }
    try {
      var response = await api.get(url);
      if (response.statusCode == 200) {
        var movie = movieFromJson(response.body);
        List.generate(100, (index) => list.add(movie));
      }
      emit(MovieListState(list));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
