class RatingProductModel {
  RatingProductModel(
      {required this.name,
      required this.urlImage,
      required this.idShopperUser,
      required this.idProduct,
      required this.rating,
      required this.date});

  String name;
  String urlImage;
  String idShopperUser;
  String idProduct;
  double rating;
  String date;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "urlImage": urlImage,
      "idShopperUser": idShopperUser,
      "idProduct": idProduct,
      "rating": rating,
      "date": date
    };
  }

  factory RatingProductModel.fromMap(Map<String, dynamic>? map) {
    return RatingProductModel(
        name: map?["name"],
        urlImage: map?["urlImage"],
        idShopperUser: map?["idShopperUser"],
        idProduct: map?["idProduct"],
        rating: map?["rating"],
        date: map?["date"]);
  }
}
