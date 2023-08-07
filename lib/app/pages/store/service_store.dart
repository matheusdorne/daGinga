import 'package:flutter/material.dart';
import 'package:daginga_server_status/app/data/models/services.dart';
import 'package:daginga_server_status/app/data/repositories/services_repositories.dart';

import '../../data/http/exceptions.dart';

class ServiceStore {
  final ServicesRepository repository;

  //Loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  //State
  final ValueNotifier<List<Service>> state = ValueNotifier<List<Service>>([]);

  //Error
  final ValueNotifier<String> error = ValueNotifier<String>('');

  ServiceStore({required this.repository});

  Future getServices() async {
    isLoading.value = true;

    try {
      final result = await repository.getServices();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();

      isLoading.value = false;
    }
  }
}
