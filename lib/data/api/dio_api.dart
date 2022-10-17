// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:project_dicoding_fundamental/data/model/dio_model.dart';
import 'package:project_dicoding_fundamental/data/model/dio_response.dart';

//CLASS API
class DioAPI {
  static const String _BASE_URL = "https://restaurant-api.dicoding.dev";
  static const String _LIST = 'list';
  static const String _DETAIL = 'detail';
  static const String _SEARCH = 'search?q=';

  //MENDAPATKAN LIST DATA
  Future<DioToResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse('$_BASE_URL/$_LIST'));
    if (response.statusCode == 200) {
      return DioToResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('GAGAL MEMUAT DATA!');
    }
  }

  //MENAMPILKAN DATA
  Future<DioModel> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_BASE_URL/$_DETAIL/$id'));
    if (response.statusCode == 200) {
      return DioModel.fromJson(json.decode(response.body)['restaurant']);
    } else {
      throw Exception('GAGAL MEMUAT DATA!');
    }
  }

  //MENCARI DATA
  Future<DioToResponse> getRestaurantQuery(String query) async {
    final response = await http.get(Uri.parse('$_BASE_URL/$_SEARCH$query'));
    if (response.statusCode == 200) {
      return DioToResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('GAGAL MEMUAT DATA!');
    }
  }
}