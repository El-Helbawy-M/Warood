import 'package:flutter/material.dart';
import '../../../utilities/theme/media.dart';
import '../../../utilities/theme/text_styles.dart';

class DescribtionInputField extends StatelessWidget {
  const DescribtionInputField({
    Key? key,
    this.hint,
    this.suffixIconName,
    this.header,
    this.controller,
    required this.onChange,
  }) : super(key: key);
  final String? hint;
  final String? suffixIconName;
  final String? header;
  final TextEditingController? controller;
  final Function(String) onChange;
  OutlineInputBorder _drawBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) Text(header ?? "", style: AppTextStyles.w400.copyWith(fontSize: 14, color: Colors.black)),
        if (header != null) const SizedBox(height: 8),
        SizedBox(
          height: 88,
          width: MediaHelper.width,
          child: TextFormField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            onChanged: onChange,
            expands: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              enabledBorder: _drawBorder(color: Theme.of(context).hintColor),
              focusedBorder: _drawBorder(color: Theme.of(context).colorScheme.primary),
              errorBorder: _drawBorder(color: Theme.of(context).colorScheme.error),
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              hintStyle: AppTextStyles.w300.copyWith(fontSize: 12, color: Theme.of(context).hintColor),
            ),
          ),
        ),
      ],
    );
  }
}
