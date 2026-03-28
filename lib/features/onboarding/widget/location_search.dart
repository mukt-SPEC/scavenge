import 'package:flutter/material.dart';
import 'package:scavenge/Theme/app_colors.dart';

class LocationSearch extends StatefulWidget {
  final TextEditingController searchController;

  const LocationSearch({required this.searchController, super.key});

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintText: 'Search location',
        hintStyle: Theme.of(
          context,
        ).textTheme.labelSmall!.copyWith(color: AppColors.white),
      ),
    );
  }
}
