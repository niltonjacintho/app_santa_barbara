import 'package:app2021/app/modules/paroquias/controllers/paroquias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class ParoquiasMapaView extends GetView {
  String title = '';
  double lat = 0;
  RxDouble long = 0.0.obs;
  late GoogleMapController mapController;
  ParoquiasController paroquiasController = Get.put(ParoquiasController());
  Set<Marker> markers = new Set<Marker>();
  _onMapCreated(GoogleMapController controler) {
    mapController = controler;
    final Marker marker = Marker(
      markerId: MarkerId("1"),
      position: LatLng(paroquiasController.paroquiaAtiva.lat,
          paroquiasController.paroquiaAtiva.long),
      infoWindow: InfoWindow(
        title: paroquiasController.paroquiaAtiva.nome,
        snippet: paroquiasController.paroquiaAtiva.paroco,
      ),
    );
    // setState(() {
    markers.add(marker);
    long.value = marker.position.longitude;
    //  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paroquiasController.paroquiaAtiva.nome),
      ),
      body: Obx(
        () => GoogleMap(
          onTap: (la) => {
            print(long.value),
          },
          trafficEnabled: long.value == 00.00,
          onMapCreated: _onMapCreated,
          mapToolbarEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
              target: LatLng(paroquiasController.paroquiaAtiva.lat,
                  paroquiasController.paroquiaAtiva.long),
              zoom: 16.5),
          markers: markers,
        ),
      ),
    );
  }
}
