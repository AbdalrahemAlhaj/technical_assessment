import 'package:dio/dio.dart';
import 'package:technical_assessment/api/api_client.dart';
import '../models/user.dart';

class UserRepository{
  final ApiClient _client = ApiClient();
  List<User> users = [];

  Future<List<User>> getAllUsers() async {

    final Response response = await _client.getUsers();
    print(response.data);
    if (response.statusCode == 200 && response.data != null) {
      users = List<User>.from(response.data.map((user) => User.fromJson(user)));
      return users;
    }
    else {
      return users;
    }
  }

}