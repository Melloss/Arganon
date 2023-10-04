import 'package:flutter/material.dart';

class KidaseTitle extends StatelessWidget {
  final String title;
  const KidaseTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 15,
              color: Colors.cyanAccent,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
