import 'package:dio/dio.dart';

class ApiClient{
  final String baseURL = "https://jsonplaceholder.typicode.com/users";

  Future<Response> getUsers() async {
    late Response response;
    return response = await Dio().get(baseURL);
  }
}