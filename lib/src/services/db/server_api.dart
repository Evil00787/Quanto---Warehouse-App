import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;



final String base = 'https://localhost:5000';


class ServerApi {
  final Map<String, String> headers =  <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<Map<String, dynamic>> postDb(Map<String, dynamic> json, String address) async {
    http.Response response;
    try {
      response = await http.post(
        base + address,
        headers: headers,
        body: jsonEncode(json),
      );
      updateCookie(response);
    } catch (exception) {
      log(exception.toString());
      return {'connection': false};
    }

    return jsonDecode(response.body);
  }

  dynamic getDb(String address) async {
    final response = await http.get(base + address, headers: headers);
    updateCookie(response);
    return jsonDecode(response.body);
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}