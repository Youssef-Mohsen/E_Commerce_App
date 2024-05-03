class Product {
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.images});

  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  dynamic rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<dynamic> images;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock,
      "brand": brand,
      "category": category,
      "thumbnail": thumbnail,
      "images": images
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        discountPercentage: json['discountPercentage'],
        rating: json['rating'],
        stock: json['stock'],
        brand: json['brand'],
        category: json['category'],
        thumbnail: json['thumbnail'],
        images: json['images']
    );
  }
}
