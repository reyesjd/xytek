class RatingUserModel {
  RatingUserModel(
      {required this.name,
      required this.urlImage,
      required this.idShopperUser,
      required this.idUser,
      required this.rating,
      required this.date,
      required this.comment});

  String name;
  String urlImage;
  String idShopperUser;
  String idUser;
  double rating;
  String date;
  String comment;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "urlImage": urlImage,
      "idShopperUser": idShopperUser,
      "idProduct": idUser,
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
        idUser: map?["idProduct"],
        rating: map?["rating"],
        date: map?["date"],
        comment: map?["comment"]);
  }
}
