import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String code;
  final String network;
  final String package;
  final DateTime expiry;

  const SuccessScreen({
    super.key,
    required this.code,
    required this.network,
    required this.package,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF512DA8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Success', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              const Text('Voucher Assigned!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('Code: $code',
                  style: const TextStyle(fontSize: 20, color: Colors.deepPurple)),
              const SizedBox(height: 8),
              Text('Network: $network'),
              Text('Package: $package'),
              Text('Expires: ${expiry.toLocal()}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Done', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}