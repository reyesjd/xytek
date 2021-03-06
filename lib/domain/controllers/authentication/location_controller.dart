import 'dart:async';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:xytek/data/models/user_location.dart';
import 'package:xytek/services/locator_service.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';

class LocationController extends GetxController {
  final userLocation = UserLocation(latitude: 0, longitude: 0).obs;
  var errorMsg = "".obs;
  // ignore: prefer_final_fields
  var _liveUpdate = false.obs;

  StreamSubscription<UserLocation>? _positionStreamSubscription;
  LocatorService service = Get.find();
  bool get liveUpdate => _liveUpdate.value;
  bool changeMarkers = false;

  clearLocation() {
    userLocation.value = UserLocation(latitude: 0, longitude: 0);
  }

  getLocation() async {
    try {
      userLocation.value = await service.getLocation();
    } catch (e) {
      getCustomSnackbar(
        'Error.....',
        e.toString(),
        type: CustomSnackbarType.error,
      );
    }
  }

  suscribeLocationUpdates() async {
    _liveUpdate.value = true;
    logInfo('suscribeLocationUpdates');
    await service.startStream().onError((error, stackTrace) {
      logError("Controller got the error ${error.toString()}");
      return;
    });

    _positionStreamSubscription = service.stream.listen((event) {
      logInfo("Controller event ${event.latitude}");
      userLocation.value = event;
    });
  }

  unSuscribeLocationUpdates() async {
    logInfo('unSuscribeLocationUpdates');
    _liveUpdate.value = false;
    service.stopStream();
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription?.cancel();
    } else {
      logError("Controller _positionStreamSubscription is null");
    }
  }
}
