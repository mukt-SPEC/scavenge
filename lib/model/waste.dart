import 'package:scavenge/common/enums.dart';

class Waste {
  final WasteType wasteType;
  final String material;
  final double estimatedWeight;
  final double estimatedPrice;

  Waste({
    required this.wasteType,
    required this.material,
    required this.estimatedWeight,
    required this.estimatedPrice,
  });
}
