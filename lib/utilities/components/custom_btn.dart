import 'package:flutter/material.dart';
import 'package:flutter_project_base/utilities/theme/media.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.text,
    this.buttonColor,
    this.textColor,
    this.onTap,
  });

  final double? height;
  final double? width;
  final double? radius;
  final String? text;
  final Color? buttonColor;
  final Color? textColor;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius ?? 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius ?? 8),
        child: Container(
          width: width ?? MediaHelper.width,
          height: height ?? 56,
          decoration: BoxDecoration(
            color: buttonColor ?? Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          child: Center(
            child: Text(
              text ?? "Tap here",
              style: AppTextStyles.w700.copyWith(fontSize: 14, color: textColor ?? Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
