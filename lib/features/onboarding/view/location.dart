import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:scavenge/common/app_button.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';
import 'package:scavenge/features/onboarding/view/preferred_waste.dart';

class LocationSelectPage extends ConsumerStatefulWidget {
  const LocationSelectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LocationSelectPageState();
}

class _LocationSelectPageState extends ConsumerState<LocationSelectPage> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  final _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              if (onboardingState.userType == UserType.agent) {
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PreferredWaste()),
                );
              }
            },
            child: Text(
              'Skip',
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: Color(0xffb9b9b9)),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialZoom: 8, initialCenter: LatLng(0, 0)),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',

                userAgentPackageName: 'com.example.scavenge',
              ),
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  marker: DefaultLocationMarker(
                    child: Icon(Icons.location_city),
                  ),
                  markerSize: Size(32, 32),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Column(
              children: [
                Spacer(),
                AppButton(onPressed: () {}, buttonText: 'Choose location'),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
