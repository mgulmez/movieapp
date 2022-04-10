import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movieapp/common/bloc_event.dart';
import 'package:bloc/bloc.dart';

import '../common/bloc_state.dart';
import '../models/movie.dart';

abstract class FavoritesEvent extends BlocEvent {}

abstract class FavoritesState extends BlocState {}

class GetFavoritesEvent extends FavoritesEvent {}

class AddToFavoriesEvent extends FavoritesEvent {
  final Movie movie;
  AddToFavoriesEvent(this.movie);
}

class RemoveFromFavoriesEvent extends FavoritesEvent {
  final Movie movie;
  RemoveFromFavoriesEvent(this.movie);
}

class FavoriesState extends FavoritesState {
  final List<Movie> movies;
  FavoriesState(this.movies);
}

class FavoritesBLOC extends Bloc<FavoritesEvent, BlocState> {
  final List<Movie> favorites = [];
  FavoritesBLOC() : super(InitialState()) {
    on<GetFavoritesEvent>(_getFavorites);
    on<AddToFavoriesEvent>(_addToFavorites);
    on<RemoveFromFavoriesEvent>(_removeFromFavories);
  }
  _getFavorites(GetFavoritesEvent event, Emitter<BlocState> emit) async {
    favorites.clear();
    var moviesMap =
        await FirebaseFirestore.instance.collection('favorites').get();
    moviesMap.docs.map((e) => favorites.add(Movie.fromJson(e.data())));
    emit(FavoriesState(favorites));
  }

  _addToFavorites(AddToFavoriesEvent event, Emitter<BlocState> emit) async {
    if (!favorites.any((element) => element.imdbId == event.movie.imdbId)) {
      var movie = await FirebaseFirestore.instance
          .collection('favorites')
          .add(event.movie.toJson());
      if (movie.id.isNotEmpty) {
        favorites.add(event.movie);
        emit(FavoriesState(favorites));
      }
    }
  }

  _removeFromFavories(
      RemoveFromFavoriesEvent event, Emitter<BlocState> emit) async {
    if (favorites.any((element) => element.imdbId == event.movie.imdbId)) {
      var collection = FirebaseFirestore.instance.collection('favorites');
      var query =
          await collection.where("imdbID", isEqualTo: event.movie.imdbId).get();
      for (var doc in query.docs) {
        collection.doc(doc.id).delete();
        var movie = Movie.fromJson(doc.data());
        if (movie.imdbId.isNotEmpty) {
          favorites.removeWhere((e) => e.imdbId == event.movie.imdbId);
        }
      }
      emit(FavoriesState(favorites));
    }
  }
}
