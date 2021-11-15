class ProductModel {
  String uid;
  String id;
  String name;
  String description;
  int price;
  String category;
  String urlImage;
  int amountAvalaible;

  ProductModel(
      {required this.name,
      required this.category,
      required this.description,
      required this.price,
      required this.urlImage,
      required this.id,
      required this.uid,
      required this.amountAvalaible});

  updateProduct(
      {name,
      category,
      description,
      price,
      urlImage,
      id,
      uid,
      amountAvalaible}) {
    if (name != null) {
      this.name = name;
    }
    if (category != null) {
      this.category = category;
    }
    if (description != null) {
      this.description = description;
    }
    if (price != null) {
      this.price = price;
    }
    if (urlImage != null) {
      this.urlImage = urlImage;
    }
    if (amountAvalaible != null) {
      this.amountAvalaible = amountAvalaible;
    }
  }

  Map<String, dynamic> toMap({List withKeys = const []}) {
    Map<String, dynamic> map = {
      "id": id,
      "uid": uid,
      "name": name,
      "category": category,
      "description": description,
      "price": price,
      "urlImage": urlImage,
      "amountAvalaible": amountAvalaible
    };
    if (withKeys.isNotEmpty) {
      map.removeWhere((key, value) => !withKeys.contains(key));
    }
    return map;
  }

  factory ProductModel.fromMap(Map<String, dynamic>? map) {
    return ProductModel(
        name: map?["name"],
        category: map?["category"],
        description: map?["description"],
        price: map?["price"],
        urlImage: map?["urlImage"],
        id: map?["id"],
        uid: map?["uid"],
        amountAvalaible: map?["amountAvalaible"]);
  }

  static List<String> getCategorias() {
    return [
      "Todas",
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
      "Redes"
    ];
  }
/*
  @override
  String toString() {
    return "\n"+toMap().toString()+"\n";
  }
  */
}
