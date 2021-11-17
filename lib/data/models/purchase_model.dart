class PurchaseModel {
  String id;
  late String uidShopper;
  late String uidSeller;
  late String date;
  late String paymentMethod;
  late int totalSale;
  // (pid, numeroSolicitado)
  late String productId;
  late int quantity;
  late String category;

  PurchaseModel(
      {required this.uidShopper,
      required this.date,
      required this.paymentMethod,
      required this.productId,
      required this.uidSeller,
      required this.quantity,
      required this.category,
      this.id = ""});

  Map<String, dynamic> toMap() {
    return {
      "uidShopper": uidShopper,
      "uidSeller": uidSeller,
      "date": date,
      "productId": productId,
      "paymentMethod": paymentMethod,
      "quantity": quantity,
      "category": category,
      "id": id,
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic>? map) {
    return PurchaseModel(
        date: map?["date"],
        paymentMethod: map?["paymentMethod"],
        productId: map?["productId"],
        uidSeller: map?["uidSeller"],
        uidShopper: map?["uidShopper"],
        quantity: map?["quantity"],
        category: map?["category"],
        id: map?["id"]);
  }
}
