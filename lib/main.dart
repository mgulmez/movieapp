import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:movieapp/api.dart';
import 'package:movieapp/blocs/account_bloc.dart';
import 'package:movieapp/models/movie_filter.dart';
import 'package:movieapp/storage.dart';

import 'app.dart';
import 'blocs/favorites_bloc.dart';
import 'blocs/movie_bloc.dart';
import 'blocs/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Storage.instance.init();
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];

  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBLOC>(create: (BuildContext context) => ThemeBLOC()),
    BlocProvider<AccountBLOC>(create: (BuildContext context) => AccountBLOC()),
    BlocProvider<FavoritesBLOC>(
        create: (BuildContext context) =>
            FavoritesBLOC()..add(GetFavoritesEvent())),
    BlocProvider<MovieBLOC>(
        create: (BuildContext context) =>
            MovieBLOC(OmdbApi())..add(GetMoviesEvent(MovieFilter()))),
  ], child: const App()));
}
