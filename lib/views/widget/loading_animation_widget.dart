import 'package:do_an_mobile/core/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class CircleLoading {
  OverlayEntry? _loadingEntry;

  void show(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadingEntry = _createdProgressEntry(context);
      Overlay.of(context).insert(_loadingEntry!);
    });
  }

  void hide() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadingEntry?.remove();
      _loadingEntry = null;
    });
  }

  OverlayEntry _createdProgressEntry(BuildContext context) => OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: <Widget>[
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Center(
            // child: LoadingAnimationWidget.flickr(
            //     leftDotColor: AppColor.ColorMain,
            //     rightDotColor: Colors.white,
            //     size: 70),
            child: LoadingAnimationWidget.discreteCircle(color: AppColor.ColorMain.withOpacity(0.5), size: 50),
          )
        ],
      ));

  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
