import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Tajmahal.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: colorScheme.primary,
              child: Center(
                child: Transform.rotate(
                  angle: math.pi / 12,
                  child: Text(
                    'Dream Big, Explore More!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}