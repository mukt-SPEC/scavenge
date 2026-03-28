import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/model/location.dart';

class OnboardingState {
  final UserType? userType;
  final String? name;
  final String? phoneNumber;
  final String? vehicleLicensePlate;
  final List<WasteType>? preferredWasteTypes;
  final Location? userLocation;

  OnboardingState({
    this.userType,
    this.name,
    this.phoneNumber,
    this.vehicleLicensePlate,
    this.preferredWasteTypes,
    this.userLocation,
  });

  OnboardingState copyWith({
    UserType? userType,
    String? name,
    String? phoneNumber,
    String? vehicleLicensePlate,
    List<WasteType>? preferredWasteTypes,
    Location? userLocation,
  }) {
    return OnboardingState(
      userType: userType ?? this.userType,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      vehicleLicensePlate: vehicleLicensePlate ?? this.vehicleLicensePlate,
      preferredWasteTypes: preferredWasteTypes ?? this.preferredWasteTypes,
      userLocation: userLocation ?? this.userLocation,
    );
  }
}

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() => OnboardingState();

  void setUserType(UserType type) {
    state = state.copyWith(userType: type);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setPhoneNumber(String phone) {
    state = state.copyWith(phoneNumber: phone);
  }

  void setVehicleLicensePlate(String plate) {
    state = state.copyWith(vehicleLicensePlate: plate);
  }

  void setLocation(Location location) {
    state = state.copyWith(userLocation: location);
  }

  void setPreferredWasteTypes(List<WasteType> wasteTypes) {
    state = state.copyWith(preferredWasteTypes: wasteTypes);
  }
}

/// State provider for tracking the user's selected [UserType] during onboarding.
final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(() {
      return OnboardingNotifier();
    });
