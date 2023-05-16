// ignore_for_file: inference_failure_on_instance_creation

import 'dart:math';
import 'package:faker/faker.dart';

class DataRepository {
  final _random = Random();
  final _faker = Faker();

  Future<String> fetchItem() async {
    await Future.delayed(const Duration(seconds: 1));

    if (_random.nextBool()) {
      throw Exception('Random DataRepository exception');
    }

    return _faker.animal.name();
  }
}
