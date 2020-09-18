import 'package:dr_app/configs/theme.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:dr_app/utils/styles.dart';
import 'package:flutter/material.dart';

/// A customised material [TextFormField] used to capture user input.
class LUInputField extends StatelessWidget {
  final String fieldTitle;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const LUInputField(
      {Key key,
      this.fieldTitle,
      this.hintText,
      this.obscureText = false,
      this.keyboardType,
      this.onSaved,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              fieldTitle,
              style: Styles.sectionText
                  .copyWith(color: LUTheme.of(context).primaryColor),
            ),
          ),
          TextFormField(
            autofocus: true,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: Styles.formInputText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              hintText: hintText,
              filled: true,
              fillColor: LUColors.transparentLightGray,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onSaved: onSaved,
            validator: validator ??
                (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
          ),
        ],
      ),
    );
  }
}
