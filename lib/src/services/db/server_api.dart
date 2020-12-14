import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



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
    try {
      return jsonDecode(response.body);

    } catch(exception) {
      return {"error" : "Error"};
    }
  }


  Future<Map<String, dynamic>> patchDb(Map<String, dynamic> json, String address) async {
    http.Response response;
    try {
      response = await http.patch(
        base + address,
        headers: headers,
        body: jsonEncode(json),
      );
      updateCookie(response);
    } catch (exception) {
      log(exception.toString());
      return {'connection': false};
    }
    try {
      if(response.body.isNotEmpty)
        return jsonDecode(response.body);
      else return {"success": true};

    } catch(exception) {
      return {"error" : "Error"};
    }
  }

  Future<Map<String, dynamic>> putDb(Map<String, dynamic> json, String address) async {
    http.Response response;
    try {
      response = await http.put(
        base + address,
        headers: headers,
        body: jsonEncode(json),
      );
      updateCookie(response);
    } catch (exception) {
      log(exception.toString());
      return {'connection': false};
    }
    try {
      return jsonDecode(response.body);

    } catch(exception) {
      return {"error" : "Error"};
    }
  }

  dynamic getDb(String address) async {
    final response = await http.get(base + address, headers: headers);
    updateCookie(response);
    try {
      return jsonDecode(response.body);

    } catch(exception) {
      return false;
    }
  }

  dynamic deleteDb(String address) async {
    final response = await http.delete(base + address, headers: headers);
    updateCookie(response);
    try {
      return jsonDecode(response.body);

    } catch(exception) {
      return false;
    }
  }


  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      setUserLoggedIn(cookie: headers['cookie']);
    }
  }


  void initApi() async {
    if(await isUserLoggedIn()) {
      headers['cookie'] = await getUserLoggedIn();
    }
  }


  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs != null && prefs.containsKey("cookie") && prefs.getString("cookie") != "";
  }

  Future<void> setUserLoggedIn({String cookie = ""}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.setString("cookie", cookie);
  }


  Future<String> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs?.getString("cookie");
  }
}