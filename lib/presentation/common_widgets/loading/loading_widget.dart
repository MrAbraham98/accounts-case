import 'dart:ui';

import 'package:accounts/utils/generated/assets.gen.dart';
import 'package:flutter/material.dart';

@immutable
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.child,
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Positioned.fill(
          child: AbsorbPointer(
            absorbing: isLoading,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isLoading
                  ? ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: RepaintBoundary(
                          child: Center(
                            child: Assets.animations.loading.lottie(
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}
