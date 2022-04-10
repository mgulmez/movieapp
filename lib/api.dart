import 'package:http/http.dart' as http;

class OmdbApi {
  static const String key = 'ce908b90';
  final String baseUrl;
  OmdbApi({this.baseUrl = 'http://www.omdbapi.com'});

  Future<http.Response> get(String path) async {
    path = path + (path.contains('?') ? '&' : '?') + 'apikey=$key';
    return await http.get(Uri.parse(baseUrl + path));
  }
}
