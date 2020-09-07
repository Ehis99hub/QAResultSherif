import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:roavapp/components/fragments/buttons/app_back_button.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/values/json.dart';

class MapPage extends StatefulWidget {
  const MapPage();

  @override
  State<StatefulWidget> createState() {
    return _MapPageState();
  }
}

class _MapPageState extends State<MapPage> with WidgetsBindingObserver {
  Completer<GoogleMapController> _controller = Completer();
  ValueNotifier<Position> curPos = ValueNotifier(
    Position(
      latitude: 0,
      longitude: 0,
    ),
  );

  StreamSubscription<Position> tracker;

  _MapPageState();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _trackPos();
  }

  void _trackPos() async {
    tracker = Geolocator()
        .getPositionStream(
      LocationOptions(
        accuracy: LocationAccuracy.best,
        distanceFilter: 4,
        timeInterval: 1000,
      ),
    )
        .listen(
      (Position pos) {
        curPos.value = pos;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            constraints: BoxConstraints.tightFor(
              height: scaler.sizer.height,
              width: scaler.sizer.width,
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ValueListenableBuilder(
                    valueListenable: curPos,
                    builder: (context, Position val, _) {
                      return GoogleMap(
                        buildingsEnabled: true,
                        trafficEnabled: true,
                        markers: Set<Marker>()
                          ..add(
                            Marker(
                              markerId: MarkerId("A"),
                              position: LatLng(
                                val.latitude,
                                val.longitude,
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(.9),
                            ),
                          )
                          ..add(
                            Marker(
                              markerId: MarkerId('B'),
                              position: LatLng(
                                hospitalLocation.lat,
                                hospitalLocation.long,
                              ),
                            ),
                          ),
                        mapType: MapType.terrain,
                        onMapCreated: (GoogleMapController controller) {
                          // _ctrl = controller;
                          _controller.complete(controller);
                        },
                        indoorViewEnabled: true,
                        myLocationEnabled: true,
                        compassEnabled: false,
                        initialCameraPosition: CameraPosition(
                          zoom: 15,
                          bearing: 30,
                          target: LatLng(
                            hospitalLocation.lat,
                            hospitalLocation.long,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  child: SafeArea(
                    child: AppBackButton(),
                  ),
                  top: scaler.sizer.setHeight(1),
                  left: scaler.sizer.setWidth(4),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    if (tracker != null) {
      tracker.cancel();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
