class SaleModel {
  late String uidShopper;
  late String uidSeller;
  late String date;
  late String paymentMethod;
  // (pid, numeroSolicitado)
  late List soldProduts;

  SaleModel(
      {required this.uidShopper,
      required this.date,
      required this.paymentMethod,
      required this.soldProduts,
      required this.uidSeller});

  Map<String, dynamic> toMap() {
    return {
      "uidShopper": uidShopper,
      "uidSeller": uidSeller,
      "date": date,
      "soldProduts": soldProduts,
      "paymentMethod": paymentMethod
    };
  }

  factory SaleModel.fromMap(Map<String, dynamic>? map) {
    return SaleModel(
        date: map?["date"],
        paymentMethod: map?["paymentMethod"],
        soldProduts: map?["soldProduts"],
        uidSeller: map?["uidSeller"],
        uidShopper: map?["uidShopper"]);
  }
}
