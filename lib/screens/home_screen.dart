import 'dart:math';

import 'package:demo_app/main.dart';
import 'package:demo_app/model/location.dart';
import 'package:demo_app/services/api_client_service.dart';
import 'package:demo_app/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        leading: IconButton(
          onPressed: () async {
            sp.remove("access_token");
            Navigator.of(context)
                .pushReplacementNamed(RouteGenerator.loginPage);
          },
          icon: const Icon(
            FontAwesomeIcons.circleArrowLeft,
            color: Colors.white,
            size: 30,
          ),
        ),
        centerTitle: false,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                sp.remove("access_token");
                Navigator.of(context)
                    .pushReplacementNamed(RouteGenerator.loginPage);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: FutureBuilder(
          future: ApiClient.getLocation(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 25),
              );
            } else if (snap.connectionState == ConnectionState.done) {
              final res = snap.data as List<LocationData>;

              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    gestureRecognizers: {
                      Factory<OneSequenceGestureRecognizer>(
                        () => PanGestureRecognizer(),
                      ),
                    },
                    zoomControlsEnabled: true,
                    markers: res
                        .map((e) => Marker(
                              infoWindow: InfoWindow(
                                  title:
                                      "${e.location}, ${e.latitude},${e.longitude}"),
                              position: LatLng(e.latitude!, e.longitude!),
                              markerId:
                                  MarkerId(Random().nextInt(100).toString()),
                            ))
                        .toSet(),
                    initialCameraPosition: const CameraPosition(
                        zoom: 12, target: LatLng(20.3409, 85.8057)),
                    onTap: (pos) {
                      // _controller.showMarkerInfoWindow(markerId)
                    }),
              );
            } else {
              return const Center(
                child: HeadlineTextWidget(
                  text: "Couldn't load map!",
                ),
              );
            }
          }),
    );
  }
}
