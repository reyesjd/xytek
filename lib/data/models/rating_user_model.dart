class RatingUserModel {
  RatingUserModel(
      {required this.name,
      required this.urlImage,
      required this.idShopperUser,
      required this.idSeller,
      required this.rating,
      required this.date,
      required this.comment});

  String name;
  String urlImage;
  String idShopperUser;
  String idSeller;
  double rating;
  String date;
  String comment;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "urlImage": urlImage,
      "idShopperUser": idShopperUser,
      "idSeller": idSeller,
      "rating": rating,
      "date": date,
      "comment": comment
    };
  }

  factory RatingUserModel.fromMap(Map<String, dynamic>? map) {
    return RatingUserModel(
        name: map?["name"],
        urlImage: map?["urlImage"],
        idShopperUser: map?["idShopperUser"],
        idSeller: map?["idSeller"],
        rating: map?["rating"],
        date: map?["date"],
        comment: map?["comment"]);
  }
}
