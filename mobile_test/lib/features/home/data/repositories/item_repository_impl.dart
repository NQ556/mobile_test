import 'package:fpdart/src/either.dart';
import 'package:mobile_test/core/error/exception.dart';
import 'package:mobile_test/core/error/failure.dart';
import 'package:mobile_test/features/home/data/datasources/item_datasource.dart';
import 'package:mobile_test/features/home/domain/entities/food.dart';
import 'package:mobile_test/features/home/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDatasource itemDatasource;

  ItemRepositoryImpl(this.itemDatasource);

  @override
  Future<Either<Failure, List<Food>>> getItems() async {
    try {
      final items = await itemDatasource.getItems();
      return right(items);
    } on MyException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Food>>> loadMoreItems(
      {required int offset}) async {
    try {
      final items = await itemDatasource.loadMoreItems(offset: offset);
      return right(items);
    } on MyException catch (e) {
      return left(Failure(e.message));
    }
  }
}
