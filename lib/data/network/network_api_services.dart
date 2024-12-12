import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm/data/app_exception.dart';
import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/shared/shared.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices implements BaseApiServices {
  @override
  Future getApiResponse(String endpoint) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.https(Const.baseUrl, endpoint), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network request time out!');
    }

    return responseJson;
  }

  @override
  Future postApiResponse(String url, dynamic data, {Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers ?? {
          'Content-Type': 'application/x-www-form-urlencoded',
          'key': Const.apiKey,
        },
        body: data.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}').join('&'),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network request time out!');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with server');
    }
  }
}
