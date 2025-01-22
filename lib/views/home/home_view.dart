import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 62),
              const Text('Home'),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Go back'),),
            ],
          ),
        ),
      ),
    );
  }
}
