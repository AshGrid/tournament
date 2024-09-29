import 'package:flutter/material.dart';

class PhaseDetailsScreen extends StatelessWidget {
  final String phaseName;

  const PhaseDetailsScreen({super.key, required this.phaseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(phaseName),
      ),
      body: Center(
        child: Text(
          'Details for $phaseName',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
