import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreferredWaste extends ConsumerStatefulWidget {
  const PreferredWaste({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreferredWasteState();
}

class _PreferredWasteState extends ConsumerState<PreferredWaste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}
