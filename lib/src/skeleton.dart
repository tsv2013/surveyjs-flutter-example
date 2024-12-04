import 'package:flutter/material.dart';

class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
            decoration: const InputDecoration(
                labelText: 'Label', border: OutlineInputBorder()))
      ],
    );
  }
}
