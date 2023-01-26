import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AppRequest {
  Future<dynamic> getRequest(Uri uri,Map<String, String> headers) async {
    try {
      log('GET $uri');
      var response = await http.get(uri,headers:headers );
      if (response.statusCode == 200) {
        log(response.body);

        var resBody = jsonDecode(response.body);
        return resBody;
      }
      log('ERROR for the $uri');
      return null;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<dynamic> postRequest(Uri uri, Map<String, dynamic> body,String email) async {
    try {
      var jsonBody = jsonEncode(body);
      var response = await http.post(
       uri,
        headers:
         <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'email':email,
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
      throw Exception(e);
    }
  }
}
