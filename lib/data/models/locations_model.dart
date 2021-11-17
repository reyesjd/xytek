class LocationsModel {
  // type Geolocation - type Complete
  late String type;

  late String nickName;

  // type Geolocation
  late List? coordinates;

  // type Complete
  late String? department;
  late String? city;
  late String? neighborhood;
  late String? typeLocation;
  late int? numberLocation;
  late String? street;

  LocationsModel(
      {required this.type,
      required this.nickName,
      this.coordinates,
      this.department,
      this.city,
      this.neighborhood,
      this.typeLocation,
      this.numberLocation,
      this.street});

  Map<String?, dynamic> toMap() {
    return {
      "type": type,
      "nickName": nickName,
      "coordinates": coordinates,
      "city": city,
      "department": department,
      "neighborhood": neighborhood,
      "typeLocation": typeLocation,
      "numberLocation": numberLocation,
      "street": street
    };
  }

  factory LocationsModel.fromMap(Map<String, dynamic>? map) {
    return LocationsModel(
        type: map?["type"],
        nickName: map?["nickName"],
        city: map?["city"],
        coordinates: map?["coordinates"],
        department: map?["department"],
        neighborhood: map?["neighborhood"],
        numberLocation: map?["numberLocation"],
        street: map?["street"],
        typeLocation: map?["typeLocation"]);
  }
}
