//Just some widgets that I will probaly need to reuse throughout the app

import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReusableWidgets {
  static Widget loadingAnimation(double size) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.progressiveDots(
          color: AppConstants.primary,
          size: size,
        ),
      ),
    );
  }
   static Widget loadingAnimationVar2(double size) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: AppConstants.primary,
          size: size,
        ),
      ),
    );
  }
}
