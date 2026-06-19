import 'package:dio/dio.dart';

class RawgService {

  final Dio dio = Dio();

  Future<Map<String, dynamic>> getGames(
  int page, {
  String search = "",
}) async {

  final response = await dio.get(
    "https://api.rawg.io/api/games",
    queryParameters: {
      "key": "68091af3bec445a8936a09afc22a086b",
      "page": page,
      "page_size": 20,
      if (search.isNotEmpty) "search": search,
    },
  );

  return response.data;
}
}