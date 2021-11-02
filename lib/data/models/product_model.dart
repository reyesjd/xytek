class ProductModel {
  String uid;
  //uid + autoIncremental
  String id;
  String name;
  String description;
  int price;
  String category;
  String urlImage;

  ProductModel(
      {required this.name,
      required this.category,
      required this.description,
      required this.price,
      required this.urlImage,
      required this.id,
      required this.uid});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "name": name,
      "category": category,
      "description": description,
      "price": price,
      "urlImage": urlImage
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic>? map) {
    return ProductModel(
        name: map?["name"],
        category: map?["category"],
        description: map?["description"],
        price: map?["price"],
        urlImage: map?["urlImage"],
        id: map?["id"],
        uid: map?["uid"]);
  }

  static List<String> getCategorias() {
    return [
      "Placas Base",
      "Procesadores",
      "Discos Duros",
      "Tarjetas Graficas",
      "Memorias RAM",
      "Grabadoras",
      "Multilectores",
      "Tarjetas de Sonido",
      "Torres/Cajas/Gabinetes",
      "Ventilacion",
      "Fuente de Alimentacion",
      "Modding",
      "Computadores Portatiles",
      "Computadores de Mesa",
      "Redes",
      "Otra"
    ];
  }
}
