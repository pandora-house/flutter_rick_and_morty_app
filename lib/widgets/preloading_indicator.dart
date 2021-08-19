import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreloadingIndicator extends StatelessWidget {
  const PreloadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child:
          SizedBox(height: 24, width: 24, child: CircularProgressIndicator()),
    );
  }
}
