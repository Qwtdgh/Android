import 'dart:async';
import 'dart:convert' as Convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef RequestCallBack = void Function(Map data);

class HttpRequest {
  final baseUrl;

  HttpRequest(this.baseUrl);

//   Future<dynamic> get(String uri, {Map<String, String>? headers}) async {
//     try {
//       http.Response response = await http.get(baseUrl + uri, headers: headers);
//       final statusCode = response.statusCode;
//       final body = response.body;
//       // print('[uri=$uri][statusCode=$statusCode][response=$body]');
//       var result = Convert.jsonDecode(body);
//       return result;
//     } on Exception catch (e) {
//       print('[uri=$uri]exception e=${e.toString()}');
//       return '';
//     }
//   }
//
//   Future<dynamic> getResponseBody(String uri, {Map<String, String>? headers}) async {
//     try {
//       http.Response response = await http.get(baseUrl + uri, headers: headers);
//       final statusCode = response.statusCode;
//       final body = response.body;
// //      var result = Convert.jsonDecode(body);
//       print('[uri=$uri][statusCode=$statusCode][response=$body]');
//       return body;
//     } on Exception catch (e) {
//       print('[uri=$uri]exception e=${e.toString()}');
//       return null;
//     }
//   }

  Future<dynamic> post(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.post(Uri.parse(baseUrl + uri), body: body, headers: headers);
      final statusCode = response.statusCode;
      final responseBody = response.body;
      var result = Convert.jsonDecode(responseBody);
      print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
      return result;
    } on Exception catch (e) {
      print('[uri=$uri]exception e=${e.toString()}');
      return '';
    }
  }
}
