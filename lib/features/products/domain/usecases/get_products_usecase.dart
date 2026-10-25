import '../entities/product_entity.dart';
import '../repositories/i_product_repository.dart';

class GetProductsUseCase {
  final IProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductEntity>> call({String? category, String? query}) {
    return repository.getProducts(category: category, query: query);
  }
}
