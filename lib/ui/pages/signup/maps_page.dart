import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/locations_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/location_controller.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';

class MapSignUpUser extends StatefulWidget {
  MapSignUpUser({Key? key}) : super(key: key) {
    locationController = Get.find();
    authController = Get.find();
    locationController.suscribeLocationUpdates();
    locationController.getLocation();
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

  @override
  Widget build(BuildContext context) {
    late String nickname;
    return Scaffold(
      appBar: WidgetAppBarBack(actionButtonBack: () {
        Get.back();
      }).build(context),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {
            print(
                "${widget.locationController.userLocation.value.latitude},${widget.locationController.userLocation.value.longitude}");
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
                            if (controllerT.text.isNotEmpty) {
                              LocationsModel locationModel = LocationsModel(
                                  type: "Geolocation",
                                  nickName: controllerT.text,
                                  coordinates: [
                                    widget.locationController.userLocation.value
                                        .latitude,
                                    widget.locationController.userLocation.value
                                        .longitude
                                  ]);
                              print("Creo la ubicacion");

                              widget.authController.userLocation =
                                  locationModel;
                              Get.close(2);
                              Get.snackbar("Actualización exitosa",
                                  " Se añadio la ubicación exitosamente",
                                  backgroundColor: Colors.green);
                              widget.locationController
                                  .unSuscribeLocationUpdates();
                            } else {
                              Get.snackbar("Error agregando la ubicación",
                                  "El apodo es vacío",
                                  backgroundColor: Colors.red);
                            }
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
              Expanded(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
