class ProductEntity {
  final String? id;
  final String name;
  final String measurement;
  final double price;

  ProductEntity(
      {this.id,
      required this.name,
      required this.measurement,
      required this.price});
}
