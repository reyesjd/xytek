import 'package:flutter/material.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:xytek/data/models/locations_model.dart';
import 'package:xytek/data/models/user_location.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/location_controller.dart';

class MapSignUpUser extends StatefulWidget {
  MapSignUpUser({Key? key}) : super(key: key) {
    locationController = Get.find();
    authController = Get.find();
    if (!locationController.liveUpdate) {
      locationController.suscribeLocationUpdates();
    }
  }

  late LocationController locationController;
  late AuthController authController;

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<MapSignUpUser> {
  late GoogleMapController googleMapController;
  late TextEditingController controllerT = TextEditingController(text: "");

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  LatLngBounds _bounds(Set<Marker> markers) {
    logInfo('Creating new bounds');
    return _createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }

  @override
  Widget build(BuildContext context) {
    late String nickname;
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text('Digita el apodo de la ubicacíon'),
                      content: TextField(controller: controllerT),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            var location = UserLocation(
                                latitude: widget.locationController.userLocation
                                    .value.latitude,
                                longitude: widget.locationController
                                    .userLocation.value.longitude);
                            if (controllerT.text.isNotEmpty) {
                              
                              widget.authController.userLocation =
                                  LocationsModel(
                                      type: "Geolocation",
                                      nickName: controllerT.text,
                                      coordinates: [
                                    location.latitude,
                                    location.longitude
                                  ]);
                              widget.locationController
                                  .unSuscribeLocationUpdates();
                            }
                            Navigator.pop(context, 'Guardar ubicación');
                          },
                          child: const Text('Guardar ubicación'),
                        ),
                      ],
                    ));
          },
          child: Icon(
            Icons.save,
            size: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GetX<LocationController>(builder: (controller) {
                logInfo('Recreating map');
                return Expanded(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    mapType: MapType.normal,
                    markers: <Marker>{},
                    myLocationEnabled: true,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(11.0227767, -74.81611),
                      zoom: 17.0,
                    ),
                  ),
                );
              }),
              GetX<LocationController>(
                builder: (controller) {
                  if (controller.userLocation.value.latitude != 0) {
                    googleMapController.moveCamera(CameraUpdate.newLatLng(
                        LatLng(controller.userLocation.value.latitude,
                            controller.userLocation.value.longitude)));
                  }
                  logInfo("UI <" +
                      controller.userLocation.value.latitude.toString() +
                      " " +
                      controller.userLocation.value.longitude.toString() +
                      ">");

                  return Text(
                    controller.userLocation.value.latitude.toString() +
                        " " +
                        controller.userLocation.value.longitude.toString(),
                    key: Key("position"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
