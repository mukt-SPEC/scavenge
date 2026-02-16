import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  final VoidCallback onRefresh;
  const ErrorScreen({super.key, required this.error, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            ElevatedButton(onPressed: onRefresh, child: Text('Refresh')),
          ],
        ),
      ),
    );
  }
}
