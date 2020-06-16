// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:glow/theme.dart';

// class BaseTextField extends StatelessWidget {
//   final Widget prefix;
//   final String labelText;
//   final String hintText;
//   final bool obscureText;
//   final List<TextInputFormatter> inputFormatters;
//   final FormFieldSetter<String> onSaved;
//   final Function(String) onChanged;
//   final Function handleObscure;
//   final Function(String) onFieldSubmitted;
//   final FormFieldValidator<String> validator;
//   final TextEditingController controller;
//   final String initialValue;
//   final bool isPassword;
//   final FocusNode focusNode;
//   final TextInputType keyboardType;
//   final TextInputAction textInputAction;
//   BaseTextField(
//       {this.prefix,
//       this.labelText,
//       this.hintText,
//       this.focusNode,
//       this.inputFormatters,
//       this.onSaved,
//       this.validator,
//       this.onChanged,
//       this.handleObscure,
//       this.onFieldSubmitted,
//       this.controller,
//       this.initialValue,
//       this.isPassword = false,
//       this.obscureText = false,
//       this.textInputAction = TextInputAction.done,
//       this.keyboardType = TextInputType.number})
//       : super();

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       inputFormatters: inputFormatters,
//       onSaved: (value) {
//         var scope = FocusScope.of(context);
//         if (!scope.hasPrimaryFocus) {
//           scope.unfocus();
//         }
//         onSaved(value);
//       },
//       validator: validator,
//       obscureText: obscureText,
//       onChanged: onChanged,
//       focusNode: focusNode,
//       maxLines: 1,
//       onFieldSubmitted: onFieldSubmitted,
//       textInputAction: textInputAction,
//       initialValue: initialValue,
//       keyboardType: keyboardType,
//       style: TextStyle(
//           color: Colors.grey[900], fontSize: 16.0, fontFamily: primaryFont),
//       decoration: new InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: labelText,
//         labelStyle: TextStyle(
//             color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14.0),
//         hintStyle: TextStyle(
//             color: Colors.grey, fontSize: 16.0, fontFamily: primaryFont),
//         prefixIcon: prefix == null
//             ? null
//             : new Padding(
//                 padding: EdgeInsetsDirectional.only(end: 12.0),
//                 child: prefix,
//               ),
//         suffixIcon: isPassword
//             ? GestureDetector(
//                 onTap: handleObscure,
//                 child: Padding(
//                   padding: EdgeInsetsDirectional.only(end: 12.0),
//                   child: obscureText
//                       ? Icon(Icons.visibility_off, size: 25)
//                       : Icon(Icons.visibility, size: 25),
//                 ),
//               )
//             : null,
//         errorStyle: TextStyle(fontSize: 12.0, fontFamily: primaryFont),
//         errorMaxLines: 3,
//         isDense: true,
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey, width: 0.5)),
//         focusedBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Theme.of(context).accentColor, width: 1.0)),
//         hintText: hintText,
//       ),
//     );
//   }
// }

// class NumberField extends CreditCardTextField {
//   NumberField(
//       {@required TextEditingController controller,
//       @required CreditCard card,
//       @required FormFieldSetter<String> onSaved,
//       @required Widget suffix,
//       Function(String) onFieldSubmitted})
//       : super(
//           hintText: '4242 4242 4242 4242',
//           controller: controller,
//           suffix: suffix,
//           onSaved: onSaved,
//           onFieldSubmitted: onFieldSubmitted,
//           validator: (String value) => validateCardNum(value, card),
//           inputFormatters: [
//             WhitelistingTextInputFormatter.digitsOnly,
//             new LengthLimitingTextInputFormatter(19),
//             new CardNumberInputFormatter()
//           ],
//         );
//   static String validateCardNum(String input, CreditCard card) {
//     if (input.isEmpty) {
//       return Strings.invalidNumber;
//     }
//     input = CardUtils.getCleanedNumber(input);
//     return card.validNumber(input) ? null : Strings.invalidNumber;
//   }
// }

// class PhoneNumberField extends BaseTextField {
//   PhoneNumberField(
//       {@required Widget prefix,
//       @required onSaved,
//       @required focusNode,
//       textInputAction,
//       Function(String) onFieldSubmitted})
//       : super(
//           labelText: 'PHONE NUMBER',
//           hintText: 'Eg 08012345678',
//           textInputAction: textInputAction,
//           keyboardType: TextInputType.number,
//           onSaved: onSaved,
//           onFieldSubmitted: onFieldSubmitted,
//           focusNode: focusNode,
//           validator: validatePhone,
//           prefix: prefix,
//           inputFormatters: [
//             WhitelistingTextInputFormatter.digitsOnly,
//             new LengthLimitingTextInputFormatter(11),
//           ],
//         );
//   static String validatePhone(String value) {
//     return value.length != 11 ? Strings.invalidPhoneNumber : null;
//   }
// }

// class PasswordField extends BaseTextField {
//   PasswordField(
//       {@required Widget prefix,
//       @required onSaved,
//       @required focusNode,
//       @required onChanged,
//       textInputAction,
//       bool obscureText,
//       @required Function obscure,
//       Function(String) onFieldSubmitted})
//       : super(
//           labelText: 'PASSWORD',
//           obscureText: obscureText,
//           textInputAction: textInputAction,
//           handleObscure: obscure,
//           focusNode: focusNode,
//           onFieldSubmitted: onFieldSubmitted,
//           isPassword: true,
//           onChanged: onChanged,
//           keyboardType: TextInputType.text,
//           onSaved: onSaved,
//           validator: validatePassword,
//           prefix: prefix,
//         );
//   static String validatePassword(String value) {
//     return value.length <= 5 ? Strings.passwordShortLength : null;
//   }
// }

// class ConfirmPasswordField extends BaseTextField {
//   ConfirmPasswordField(
//       {@required Widget prefix,
//       @required onSaved,
//       String password,
//       textInputAction,
//       @required focusNode,
//       bool obscureText,
//       Function(String) onFieldSubmitted,
//       @required Function obscure})
//       : super(
//             labelText: 'CONFIRM PASSWORD',
//             obscureText: obscureText,
//             textInputAction: textInputAction,
//             onFieldSubmitted: onFieldSubmitted,
//             handleObscure: obscure,
//             focusNode: focusNode,
//             isPassword: true,
//             keyboardType: TextInputType.text,
//             onSaved: onSaved,
//             validator: (pw) => validatePassword(pw, password),
//             prefix: prefix);
//   static String validatePassword(String a, String b) {
//     return a != b ? Strings.passwordNotMatch : null;
//   }
// }

// class EmailField extends BaseTextField {
//   EmailField(
//       {@required FormFieldSetter<String> onSaved,
//       @required Widget prefix,
//       @required focusNode,
//       textInputAction,
//       Function(String) onFieldSubmitted})
//       : super(
//             labelText: 'EMAIL ADDRESS',
//             hintText: 'Eg abc@gmail.com',
//             onSaved: onSaved,
//             onFieldSubmitted: onFieldSubmitted,
//             focusNode: focusNode,
//             validator: validateEmail,
//             keyboardType: TextInputType.emailAddress,
//             prefix: prefix,
//             textInputAction: textInputAction);

//   static String validateEmail(String value) {
//     return value.isNotEmpty && value.contains('@')
//         ? null
//         : Strings.invalidEmail;
//   }
// }

// /// regular default textfield
// class RegField extends BaseTextField {
//   RegField(
//       {@required FormFieldSetter<String> onSaved,
//       @required Widget prefix,
//       String labelText,
//       textInputAction,
//       keyboardType = TextInputType.text,
//       @required focusNode,
//       Function(String) onFieldSubmitted,
//       String hintText})
//       : super(
//           labelText: labelText,
//           hintText: hintText,
//           onSaved: onSaved,
//           textInputAction: textInputAction,
//           onFieldSubmitted: onFieldSubmitted,
//           focusNode: focusNode,
//           validator: validateField,
//           keyboardType: keyboardType,
//           prefix: prefix,
//         );

//   static String validateField(String value) {
//     return value.isNotEmpty ? null : Strings.fieldReq;
//   }
// }

// class CardNumberInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     var text = newValue.text;

//     if (newValue.selection.baseOffset == 0) {
//       return newValue;
//     }

//     var buffer = new StringBuffer();
//     for (int i = 0; i < text.length; i++) {
//       buffer.write(text[i]);
//       var nonZeroIndex = i + 1;
//       if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
//         buffer.write(' ');
//       }
//     }

//     var string = buffer.toString();
//     return newValue.copyWith(
//         text: string,
//         selection: new TextSelection.collapsed(offset: string.length));
//   }
// }

// class CardMonthInputFormatter extends TextInputFormatter {
//   String previousText;
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     var text = newValue.text;

//     if (newValue.selection.baseOffset == 0) {
//       return newValue;
//     }

//     var buffer = new StringBuffer();
//     for (int i = 0; i < text.length; i++) {
//       buffer.write(text[i]);
//       var nonZeroIndex = i + 1;

//       if (nonZeroIndex % 2 == 0 &&
//           ((!_isDeletion(previousText, text) && nonZeroIndex != 4) ||
//               (nonZeroIndex != text.length))) {
//         buffer.write('/');
//       }
//     }

//     previousText = text;
//     var string = buffer.toString();
//     return newValue.copyWith(
//         text: string,
//         selection: new TextSelection.collapsed(offset: string.length));
//   }
// }

// bool _isDeletion(String prevText, String newText) {
//   if (prevText == null) {
//     return false;
//   }

//   return prevText.length > newText.length;
// }

// class DateField extends CreditCardTextField {
//   DateField(
//       {@required CreditCard card, @required FormFieldSetter<String> onSaved})
//       : super(
//           hintText: 'MM/YY',
//           validator: validateDate,
//           initialValue: _getInitialExpiryMonth(card),
//           onSaved: onSaved,
//           inputFormatters: [
//             WhitelistingTextInputFormatter.digitsOnly,
//             new LengthLimitingTextInputFormatter(4),
//             new CardMonthInputFormatter()
//           ],
//         );
//   static String _getInitialExpiryMonth(CreditCard card) {
//     if (card == null) {
//       return null;
//     }
//     if (card.expiryYear == null ||
//         card.expiryMonth == null ||
//         card.expiryYear == 0 ||
//         card.expiryMonth == 0) {
//       return null;
//     } else {
//       return '${card.expiryMonth}/${card.expiryYear}';
//     }
//   }

//   static String validateDate(String value) {
//     if (value.isEmpty) {
//       return Strings.invalidExpiry;
//     }

//     int year;
//     int month;
//     // The value contains a forward slash if the month and year has been
//     // entered.
//     if (value.contains(new RegExp(r'(\/)'))) {
//       var split = value.split(new RegExp(r'(\/)'));
//       // The value before the slash is the month while the value to right of
//       // it is the year.
//       month = int.parse(split[0]);
//       year = int.parse(split[1]);
//     } else {
//       // Only the month was entered
//       month = int.parse(value.substring(0, (value.length)));
//       year = -1; // Lets use an invalid year intentionally
//     }

//     if (!CardUtils.validExpiryDate(month, year)) {
//       return Strings.invalidExpiry;
//     }
//     return null;
//   }
// }

// class CVCField extends CreditCardTextField {
//   CVCField(
//       {@required CreditCard card, @required FormFieldSetter<String> onSaved})
//       : super(
//           hintText: '123',
//           onSaved: onSaved,
//           validator: (String value) => validateCVC(value, card),
//           initialValue:
//               card != null && card.cvc != null ? card.cvc.toString() : null,
//           inputFormatters: [
//             WhitelistingTextInputFormatter.digitsOnly,
//             new LengthLimitingTextInputFormatter(3),
//           ],
//         );

//   static String validateCVC(String value, CreditCard card) {
//     if (value == null || value.trim().isEmpty) return Strings.invalidCVC;

//     return card.validCVC(value) ? null : Strings.invalidCVC;
//   }
// }

// / base testfield for credit card widgets
// class CreditCardTextField extends StatelessWidget {
//   final String hintText;
//   final List<TextInputFormatter> inputFormatters;
//   final FormFieldSetter<String> onSaved;
//   final Function(String) onChanged;
//   final Function(String) onFieldSubmitted;
//   final FormFieldValidator<String> validator;
//   final TextEditingController controller;
//   final String initialValue;
//   final Widget suffix;

//   final TextInputType keyboardType;
//   final TextInputAction textInputAction;
//   CreditCardTextField(
//       {this.hintText,
//       this.suffix,
//       this.inputFormatters,
//       this.onSaved,
//       this.validator,
//       this.onChanged,
//       this.onFieldSubmitted,
//       this.controller,
//       this.initialValue,
//       this.textInputAction = TextInputAction.done,
//       this.keyboardType = TextInputType.number})
//       : super();

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//         controller: controller,
//         inputFormatters: inputFormatters,
//         onSaved: (value) {
//           onSaved(value);
//         },
//         validator: validator,
//         onChanged: onChanged,
//         onFieldSubmitted: onFieldSubmitted,
//         textInputAction: textInputAction,
//         initialValue: initialValue,
//         keyboardType: keyboardType,
//         style: TextStyle(
//             color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
//         decoration: InputDecoration(
//             suffixIcon: suffix == null
//                 ? null
//                 : new Padding(
//                     padding: EdgeInsetsDirectional.only(end: 12.0),
//                     child: suffix,
//                   ),
//             contentPadding: EdgeInsets.only(top: 20),
//             border: InputBorder.none,
//             hintText: "$hintText",
//             hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)));
//   }
// }
