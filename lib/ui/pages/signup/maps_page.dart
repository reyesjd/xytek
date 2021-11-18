import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/locations_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/location_controller.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';

// ignore: must_be_immutable
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
    return Scaffold(
      appBar: WidgetAppBarBack(actionButtonBack: () {
        Get.back();
      }).build(context),
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

                              widget.authController.userLocation =
                                  locationModel;
                              Get.close(2);
                              getCustomSnackbar(
                                "Actualización exitosa",
                                "Se añadió la ubicación exitosamente",
                                type: CustomSnackbarType.success,
                              );
                              widget.locationController
                                  .unSuscribeLocationUpdates();
                            } else {
                              getCustomSnackbar(
                                "Error agregando la ubicación",
                                "El apodo es vacío",
                                type: CustomSnackbarType.error,
                              );
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
