import 'dart:convert';

import 'package:http/http.dart';

class Network {
  final String url;

  Network(this.url);

  Future<dynamic> fetchData() async {
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
