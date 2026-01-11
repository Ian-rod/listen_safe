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

///A generalised output snackbar based on result with atleast one entry
  static void operationResultSnackbar(Map<bool,String> result,BuildContext context)
  {
    MapEntry<bool,String> resultEntry=result.entries.first;
      late SnackBar outputSnackbar;
      if(resultEntry.key)
      {
        outputSnackbar=SnackBar(content: Text( resultEntry.value),backgroundColor: AppConstants.success);
      }
      else{
        outputSnackbar=SnackBar(content: Text( resultEntry.value),backgroundColor: AppConstants.error);
      }
      ScaffoldMessenger.of(context).showSnackBar(outputSnackbar);
  }
}
