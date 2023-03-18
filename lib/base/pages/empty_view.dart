import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utilities/theme/media.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(24),
      child: Lottie.asset(
        'assets/lottie/empty_animation.json',
        width: MediaHelper.width,
        height: 250,
        fit: BoxFit.contain,
      ),
    ));
  }
}
