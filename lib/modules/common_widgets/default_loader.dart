import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DefaultLoader extends StatelessWidget {
  const DefaultLoader({
    super.key,
    required this.isLoad,
    required this.retryFn,
  });

  final bool isLoad;
  final void Function() retryFn;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Get.theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottieBuilder.asset('lottieFiles/pixel-loader.json',
            height: 100, frameRate: FrameRate.max, animate: isLoad),
        Visibility(
          visible: !isLoad,
          child: IconButton(
            onPressed: retryFn,
            icon: Icon(
              Icons.replay_circle_filled_outlined,
              color: colorScheme.error,
              semanticLabel: 'Retry',
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
