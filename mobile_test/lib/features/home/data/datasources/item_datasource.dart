import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobile_test/core/error/exception.dart';
import 'package:mobile_test/features/home/data/models/food_model.dart';

abstract interface class ItemDatasource {
  Future<List<FoodModel>> getItems();
  Future<List<FoodModel>> loadMoreItems({required int offset});
}

class ItemDatasourceImpl implements ItemDatasource {
  @override
  Future<List<FoodModel>> getItems() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/mock_items.json');
      final data = json.decode(response) as List;
      final List<FoodModel> items =
          data.map((e) => FoodModel.fromMap(e)).toList();
      return items.take(10).toList();
    } catch (e) {
      throw MyException(e.toString());
    }
  }

  @override
  Future<List<FoodModel>> loadMoreItems({required int offset}) async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/mock_items.json');
      final data = json.decode(response) as List;
      final List<FoodModel> items =
          data.map((e) => FoodModel.fromMap(e)).toList();

      if (offset >= items.length) {
        return [];
      }

      return items.skip(offset).take(10).toList();
    } catch (e) {
      throw MyException(e.toString());
    }
  }
}
