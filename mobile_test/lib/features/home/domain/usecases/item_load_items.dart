import 'package:fpdart/src/either.dart';
import 'package:mobile_test/core/common/usecase/usecase.dart';
import 'package:mobile_test/core/error/failure.dart';
import 'package:mobile_test/features/home/domain/entities/food.dart';
import 'package:mobile_test/features/home/domain/repositories/item_repository.dart';

class ItemLoadItems implements Usecase<List<Food>, NoParams> {
  final ItemRepository itemRepository;

  ItemLoadItems(this.itemRepository);

  @override
  Future<Either<Failure, List<Food>>> call(NoParams params) async {
    return await itemRepository.getItems();
  }
}
