import 'package:flutter/material.dart';

class SquereTile extends StatelessWidget {
  final String imagePath;
  
  const SquereTile({super.key,
  required this.imagePath,
  });
  


  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath,height: 70);
  }
}
