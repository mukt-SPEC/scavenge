import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/app_button.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';
import 'package:scavenge/features/onboarding/view/preferred_waste.dart';
import 'package:scavenge/features/onboarding/widget/location_search.dart';
import 'package:scavenge/model/location.dart' as app_model;

class LocationSelectPage extends ConsumerStatefulWidget {
  const LocationSelectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LocationSelectPageState();
}

class _LocationSelectPageState extends ConsumerState<LocationSelectPage> {
  bool _isMapReady = false;
  @override
  void initState() {
    super.initState();
    _determinePosition()
        .then((pos) {
          if (mounted) {
            setState(() {
              _currentLocation = LatLng(pos.latitude, pos.longitude);
            });
            if (_isMapReady) {
              _mapController.move(_currentLocation!, 15);
            }

            // Start listening to live location updates
            _locationSubscription = _location.onLocationChanged.listen((
              LocationData currentLocation,
            ) {
              if (currentLocation.latitude != null &&
                  currentLocation.longitude != null) {
                if (mounted) {
                  setState(() {
                    _currentLocation = LatLng(
                      currentLocation.latitude!,
                      currentLocation.longitude!,
                    );
                  });
                  if (_isMapReady) {
                    _mapController.move(
                      _currentLocation!,
                      _mapController.camera.zoom,
                    );
                  }
                }
              }
            });
          }
        })
        .catchError((e) {
          debugPrint("Error getting location: $e");
        });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  LatLng? _currentLocation;
  final _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;

  void saveLocation() {
    if (_currentLocation != null) {
      ref
          .read(onboardingProvider.notifier)
          .setLocation(
            app_model.Location(
              latitude: _currentLocation!.latitude,
              longitude: _currentLocation!.longitude,
            ),
          );
    }
  }

  Future<void> _usercurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    } else {
      try {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Fetching location...')));
        }
        final pos = await _determinePosition();
        if (mounted) {
          setState(() {
            _currentLocation = LatLng(pos.latitude, pos.longitude);
          });
          if (_isMapReady) {
            _mapController.move(_currentLocation!, 15);
          }
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$e')));
        }
      }
    }
  }

  // Future<void> _handleTap(TapPosition tapPosition, LatLng latlng) async {
  //   setState(() {
  //     _currentLocation = latlng;
  //   });
  //   _mapController.move(latlng, _mapController.camera.zoom);
  // }

  Future<void> fetchCoordinatesPoint(String location) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?format=json&q=$location',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final lat = data[0]['lat'];
        final lng = data[0]['lon'];
        if (mounted) {
          setState(() {
            _currentLocation = LatLng(double.parse(lat), double.parse(lng));
          });
          if (_isMapReady) {
            _mapController.move(_currentLocation!, 15);
          }
        }
      } else {}
    }
  }

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
  final _searchController = TextEditingController();
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
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialZoom: 8,
                initialCenter: _currentLocation ?? const LatLng(0, 0),
                onMapReady: () {
                  setState(() {
                    _isMapReady = true;
                  });
                  if (_currentLocation != null) {
                    _mapController.move(_currentLocation!, 15);
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.scavenge',
                ),
                CurrentLocationLayer(
                  style: LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      child: Icon(MingCuteIcons.mgc_user_2_fill),
                    ),
                    markerSize: Size(32, 32),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: 16,
            right: 16,
            child: LocationSearch(
              searchController: _searchController,
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  fetchCoordinatesPoint(_searchController.text.trim());
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Column(
              children: [
                Spacer(),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: () {
                          saveLocation();
                          if (onboardingState.userType == UserType.agent) {
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PreferredWaste(),
                              ),
                            );
                          }
                        },
                        buttonText: 'Choose location',
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(44, 44),
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.surfaceDark,
                      ),
                      onPressed: () {
                        _usercurrentLocation();
                      },
                      child: Icon(MingCuteIcons.mgc_map_pin_fill),
                    ),
                  ],
                ),

                SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
