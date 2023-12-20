class FavoriteModel {
  String? status;
  List<FavoriteProducts>? favoriteProducts;

  FavoriteModel({this.status, this.favoriteProducts});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['favoriteProducts'] != null) {
      favoriteProducts = <FavoriteProducts>[];
      json['favoriteProducts'].forEach((v) {
        favoriteProducts!.add(FavoriteProducts.fromJson(v));
      });
    }
  }

 
}

class FavoriteProducts {
  String? sId;
  String? status;
  String? category;
  String? name;
  double? price;
  String? description;
  String? image;
  List<String>? images;
  String? company;
  int? countInStock;
  int? iV;
  int? sales;

  FavoriteProducts(
      {this.sId,
      this.status,
      this.category,
      this.name,
      this.price,
      this.description,
      this.image,
      this.images,
      this.company,
      this.countInStock,
      this.iV,
      this.sales});

  FavoriteProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    images = json['images'].cast<String>();
    company = json['company'];
    countInStock = json['countInStock'];
    iV = json['__v'];
    sales = json['sales'];
  }

  
}
