class MovieFilter {
  String? search = 'a';
  int? year;
  int? rating;
  int page = 1;
  String sorting = 'year';

  MovieFilter copyWith(
      {String? sorting, int? year, String? search, int? rating}) {
    return MovieFilter()
      ..sorting = sorting ?? this.sorting
      ..year = year ?? this.year
      ..rating = rating ?? this.rating
      ..search = search ?? this.search;
  }
}
