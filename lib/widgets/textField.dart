import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glow/theme.dart';

class TextFieldWidget extends StatelessWidget {
  final bool isRequired;
  final String hintText;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldSetter<String> onSaved;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final String initialValue;
  final Widget suffix;
  final Widget prefix;
  final bool readOnly;
  final String helperText;
  final Function onTap;
  final String label;
  final bool isPassword;
  final bool obscureText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  TextFieldWidget(
      {this.isRequired = true,
      this.hintText,
      this.prefix,
      this.label,
      this.focusNode,
      this.onTap,
      this.helperText,
      this.readOnly = false,
      this.isPassword = false,
      this.obscureText = false,
      this.suffix,
      this.inputFormatters,
      this.onSaved,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.controller,
      this.initialValue,
      this.textInputAction = TextInputAction.done,
      this.keyboardType = TextInputType.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 10),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: "*",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
          TextSpan(
              text: "$label", style: TextStyle(fontWeight: FontWeight.w600)),
        ])),
        TextFormField(
            controller: controller,
            inputFormatters: inputFormatters,
            readOnly: readOnly,
            onTap: readOnly ? onTap : null,
            onSaved: (value) {
              var scope = FocusScope.of(context);
              if (!scope.hasPrimaryFocus) {
                scope.unfocus();
              }
              onSaved(value);
            },
            focusNode: focusNode,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            textInputAction: textInputAction,
            initialValue: initialValue,
            keyboardType: keyboardType,
            style: TextStyle(color: Colors.black, fontSize: 15.0),
            decoration: InputDecoration(
                helperText: helperText ?? null,
                suffixIcon: suffix == null
                    ? null
                    : Padding(
                        padding: EdgeInsetsDirectional.only(
                            end: 12.0, top: 15, start: 4),
                        child: suffix,
                      ),
                prefixIcon: prefix == null
                    ? null
                    : Padding(
                        padding: EdgeInsetsDirectional.only(start: 0.0),
                        child: prefix,
                      ),
                contentPadding: EdgeInsets.only(top: 15),
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 0.8)),
                hintText: "$hintText",
                hintStyle: TextStyle(fontSize: 15))),
      ],
    );
  }
}
