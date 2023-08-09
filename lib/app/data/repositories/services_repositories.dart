import 'dart:convert';
import 'dart:io';
import 'package:daginga_server_status/app/data/http/exceptions.dart';
import 'package:daginga_server_status/app/data/http/http_client.dart';
import 'package:daginga_server_status/app/data/models/services.dart';

abstract class ServicesRepository {
  Future<List<Service>> getServices();
}

void teste() async {
  final HttpClient client = HttpClientImpl();
  final response = await client.get(
    url: 'https://search.reserve4me.de/api/status/details',
  );
}

class ServicesRepositoryImpl implements ServicesRepository {
  final HttpClient client;

  ServicesRepositoryImpl({required this.client});

  @override
  Future<List<Service>> getServices() async {
    final response = await client.get(
      url: 'https://search.reserve4me.de/api/status/details',
    );

    if (response.statusCode == 200) {
      final List<Service> servicesList = [];

      final body = jsonDecode(response.body);

      body['data'].map((item) {
        final Service service = Service.fromMap(item);
        servicesList.add(service);
      }).toList();

      return servicesList;
    } else if (response.statusCode == 404) {
      throw NotFoundException('Invalid URL');
    } else {
      throw const HttpException('Unable to load data');
    }
  }
}
