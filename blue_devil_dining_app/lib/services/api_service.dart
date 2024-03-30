import "package:blue_devil_dining_app/constants.dart";
import "package:dio/dio.dart";
import "package:blue_devil_dining_app/models/menu_item.dart";

final _dio = Dio();

Future<List<MenuItem>> fetchMenuItems(String query) async {
  final requestUrl = "$apiUrl/search/?query=$query";
  final response = await _dio.get(requestUrl);
  List<dynamic> data = response.data;
  return data.map((json) => MenuItem.fromJson(json)).toList();
}
