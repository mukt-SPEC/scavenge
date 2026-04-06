import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';

class LocationSearch extends StatefulWidget {
  final TextEditingController searchController;
  final void Function()? onPressed;

  const LocationSearch({
    required this.searchController,
    this.onPressed,
    super.key,
  });

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.searchController,

            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {
                  widget.searchController.clear();
                },
                icon: const Icon(MingCuteIcons.mgc_close_fill),
              ),
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
          ),
        ),
        IconButton(
          onPressed: () {
            widget.onPressed?.call();
          },
          icon: const Icon(MingCuteIcons.mgc_search_2_fill),
        ),
      ],
    );
  }
}
