import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AppRequest {
  Future<dynamic> getRequest(String uri) async {
    try {
      log('GET $uri');
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        log('$resBody');
        return resBody;
      }
      log('ERROR for the $uri');
      return null;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<dynamic> postRequest(String uri, Map<String, dynamic> body) async {
    try {
      var jsonBody = jsonEncode(body);
      var response = await http.post(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody,
      );
      log('POST $uri');

      if (response.statusCode == 201) {
        var resBody = jsonDecode(response.body);
        return resBody;
      }
      log('Error posting  ${response.statusCode}');

      return null;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
