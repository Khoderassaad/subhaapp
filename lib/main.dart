import 'package:reall/homep.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const subha());
}

class subha extends StatelessWidget {
  const subha({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homep(),

    );
  }
}
