import 'package:flutter/material.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class ErrorHandler {
  showErrorDialog({
    required String title,
    required String message,
    String buttonText = "حسنا",
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: AppTextStyles.w500.copyWith(fontSize: 18, color: Theme.of(context).colorScheme.error)),
        content: Text(message, style: AppTextStyles.w400.copyWith(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  showErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.w400.copyWith(fontSize: 14, color: Colors.white),
        ),
        duration: const Duration(seconds: 1, milliseconds: 500),
        backgroundColor: Colors.red,
      ),
    );
  }
}
