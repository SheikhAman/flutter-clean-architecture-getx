import '../entities/product_entity.dart';

abstract class IProductRepository {
  Future<List<ProductEntity>> getProducts({String? category, String? query});
  Future<ProductEntity> getProductDetail(int id);
}
