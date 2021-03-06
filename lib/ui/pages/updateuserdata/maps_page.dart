import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/locations_model.dart';
import 'package:xytek/data/models/user_location.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/location_controller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';

// ignore: must_be_immutable
class MapUpdateUser extends StatefulWidget {
  MapUpdateUser({Key? key}) : super(key: key) {
    locationController = Get.find();
    authController = Get.find();
    locationController.suscribeLocationUpdates();
    locationController.getLocation();
  }
  var location = Get.arguments;
  late LocationController locationController;
  late AuthController authController;
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<MapUpdateUser> {
  late GoogleMapController googleMapController;

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    late TextEditingController controllerT = TextEditingController(text: "");
    return Scaffold(
      appBar: WidgetAppBarBack(actionButtonBack: () {
        Get.back();
      }).build(context),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () async {
            AuthController authController = Get.find();
            StorageController storageController = Get.find();
            List l = authController.userModelLogged.locationsModel;
            var location = UserLocation(
                latitude: widget.locationController.userLocation.value.latitude,
                longitude:
                    widget.locationController.userLocation.value.longitude);
            if (widget.location == null) {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('Digita el apodo de la ubicac??on'),
                        content: TextField(controller: controllerT),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (controllerT.text.isNotEmpty) {
                                var verif = l.where((element) =>
                                    element.nickName == controllerT.text);
                                if (verif.isEmpty) {
                                  LocationsModel locationModel = LocationsModel(
                                      type: "Geolocation",
                                      nickName: controllerT.text,
                                      coordinates: [
                                        location.latitude,
                                        location.longitude
                                      ]);
                                  l.add(locationModel);
                                  await storageController.updateUser(
                                      uid: authController.userModelLogged.uid,
                                      locationsModel:
                                          l.map((e) => e.toMap()).toList());
                                  authController.userModelLogged
                                      .update(locationsModel: l);
                                  Get.close(3);
                                  getCustomSnackbar(
                                    "Actualizaci??n exitosa",
                                    " Se a??adio la ubicaci??n exitosamente",
                                    type: CustomSnackbarType.success,
                                  );
                                  widget.locationController
                                      .unSuscribeLocationUpdates();
                                } else {
                                  getCustomSnackbar(
                                    "Error agregando la ubicaci??n",
                                    "Ya existe una ubicaci??n con ese apodo",
                                    type: CustomSnackbarType.error,
                                  );
                                }
                              }
                            },
                            child: const Text('Guardar ubicaci??n'),
                          ),
                        ],
                      ));
            } else {
              LocationsModel locationModel = LocationsModel(
                  type: "Geolocation",
                  nickName: widget.location.nickName,
                  coordinates: [location.latitude, location.longitude]);
              l.removeWhere(
                  (element) => element.nickName == widget.location.nickName);
              l.add(locationModel);
              await storageController.updateUser(
                  uid: authController.userModelLogged.uid,
                  locationsModel: l.map((e) => e.toMap()).toList());
              authController.userModelLogged.update(locationsModel: l);
              widget.locationController.unSuscribeLocationUpdates();
              Get.close(1);
              getCustomSnackbar(
                "Actualizaci??n exitosa",
                "La ubicaci??n se actualiz?? exitosamente",
                type: CustomSnackbarType.success,
              );
            }
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              widget.location == null
                  ? Expanded(
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
                    )
                  : Expanded(
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
