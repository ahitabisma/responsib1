// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'app_exception.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> post(dynamic url, dynamic data) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(dynamic url) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(dynamic url) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
