import 'package:flutter/material.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

showSnackBar({
  required String content,
}) {
  ScaffoldMessenger.of(CustomNavigator.navigatorState.currentContext!).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 2000),
      content: Row(
        children: [
          Text(
            content,
            style: AppTextStyles.w400.copyWith(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
