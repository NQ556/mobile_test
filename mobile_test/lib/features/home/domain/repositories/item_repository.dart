import 'package:fpdart/fpdart.dart';
import 'package:mobile_test/core/error/failure.dart';
import 'package:mobile_test/features/home/domain/entities/food.dart';

abstract interface class ItemRepository {
  Future<Either<Failure, List<Food>>> getItems();
  Future<Either<Failure, List<Food>>> loadMoreItems({required int offset});
}
