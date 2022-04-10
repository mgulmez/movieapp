// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

String movieToJson(Movie data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class Movie extends HiveObject {
  Movie({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.website,
    required this.response,
  });
  @HiveField(0)
  String title;
  @HiveField(1)
  String year;
  @HiveField(2)
  String rated;
  @HiveField(3)
  String released;
  @HiveField(4)
  String runtime;
  @HiveField(5)
  String genre;
  @HiveField(6)
  String director;
  @HiveField(7)
  String writer;
  @HiveField(8)
  String actors;
  @HiveField(9)
  String plot;
  @HiveField(10)
  String language;
  @HiveField(11)
  String country;
  @HiveField(12)
  String awards;
  @HiveField(13)
  String poster;
  @HiveField(14)
  List<Rating> ratings;
  @HiveField(15)
  String metascore;
  @HiveField(16)
  String imdbRating;
  @HiveField(17)
  String imdbVotes;
  @HiveField(18)
  String imdbId;
  @HiveField(19)
  String type;
  @HiveField(20)
  String dvd;
  @HiveField(21)
  String boxOffice;
  @HiveField(22)
  String production;
  @HiveField(23)
  String website;
  @HiveField(24)
  String response;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        title: json["Title"],
        year: json["Year"],
        rated: json["Rated"],
        released: json["Released"],
        runtime: json["Runtime"],
        genre: json["Genre"],
        director: json["Director"],
        writer: json["Writer"],
        actors: json["Actors"],
        plot: json["Plot"],
        language: json["Language"],
        country: json["Country"],
        awards: json["Awards"],
        poster: json["Poster"],
        ratings:
            List<Rating>.from(json["Ratings"].map((x) => Rating.fromJson(x))),
        metascore: json["Metascore"],
        imdbRating: json["imdbRating"],
        imdbVotes: json["imdbVotes"],
        imdbId: json["imdbID"],
        type: json["Type"],
        dvd: json["DVD"],
        boxOffice: json["BoxOffice"],
        production: json["Production"],
        website: json["Website"],
        response: json["Response"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "Rated": rated,
        "Released": released,
        "Runtime": runtime,
        "Genre": genre,
        "Director": director,
        "Writer": writer,
        "Actors": actors,
        "Plot": plot,
        "Language": language,
        "Country": country,
        "Awards": awards,
        "Poster": poster,
        "Ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "Metascore": metascore,
        "imdbRating": imdbRating,
        "imdbVotes": imdbVotes,
        "imdbID": imdbId,
        "Type": type,
        "DVD": dvd,
        "BoxOffice": boxOffice,
        "Production": production,
        "Website": website,
        "Response": response,
      };
}

@HiveType(typeId: 1)
class Rating extends HiveObject {
  Rating({
    required this.source,
    required this.value,
  });

  @HiveField(0)
  String source;
  @HiveField(1)
  String value;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        source: json["Source"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Source": source,
        "Value": value,
      };
}
