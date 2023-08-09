import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:daginga_server_status/app/data/http/http_client.dart';
import 'package:daginga_server_status/app/data/repositories/services_repositories.dart';
import 'package:daginga_server_status/app/data/models/services.dart';

void main() async {
  final HttpClient client = HttpClientImpl();
  final response = await client.get(
    url: 'https://search.reserve4me.de/api/status/details',

  );
  final List<Service> servicesList = [];

  final body = jsonDecode(response.body);
  body['data'].map((item) {
    final Service service = Service.fromMap(item);
    servicesList.add(service);
  }).toList();


  print(body['data']);
  
}