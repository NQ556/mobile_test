import 'package:fpdart/src/either.dart';
import 'package:mobile_test/core/common/usecase/usecase.dart';
import 'package:mobile_test/core/error/failure.dart';
import 'package:mobile_test/features/home/domain/entities/food.dart';
import 'package:mobile_test/features/home/domain/repositories/item_repository.dart';

class ItemLoadMoreItems
    implements Usecase<List<Food>, ItemLoadMoreItemsParams> {
  final ItemRepository itemRepository;
  ItemLoadMoreItems(this.itemRepository);

  @override
  Future<Either<Failure, List<Food>>> call(
      ItemLoadMoreItemsParams params) async {
    return await itemRepository.loadMoreItems(offset: params.offset);
  }
}

class ItemLoadMoreItemsParams {
  final int offset;
  ItemLoadMoreItemsParams({required this.offset});
}
