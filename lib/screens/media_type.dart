import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SelectMedia extends StatelessWidget {
  const SelectMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Builder(builder: (context)=>
      LiquidSwipe(pages: [

        //Build the selection pages here

     ])), 
    );
  }
}