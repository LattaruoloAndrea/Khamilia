import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: 100,),
        Center(child: Lottie.asset("lib/images/loading.json")),
        Text("Loading...", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),)
      ],
    ));
  }
}
