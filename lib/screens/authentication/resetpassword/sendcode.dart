// import 'dart:async';
// import 'package:after_layout/after_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:lendly/bloc/auth_bloc.dart';
// import 'package:lendly/data/network/request/resetpassword_request.dart';
// import 'package:lendly/helpers/base_field.dart';
// import 'package:lendly/helpers/functions.dart';
// import 'package:lendly/theme.dart';
// import 'package:lendly/widgets/button/flat_button.dart';
// import 'package:provider/provider.dart';

// class SendResetCode extends StatefulWidget {
//   @override
//   _SendResetCodeState createState() => _SendResetCodeState();
// }

// class _SendResetCodeState extends State<SendResetCode> {
//   var formKey = GlobalKey<FormState>();
//   FocusNode focusNode = FocusNode();
//   ResetPwRequest resetPwRequest = ResetPwRequest();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Form(
//         key: formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 25.0),
//               child: Text('Enter your email address',
//                   style: TextStyle(
//                     fontSize: 36.0,
//                     fontWeight: FontWeight.w800,
//                     fontFamily: primaryFont,
//                   )),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     'We\'ll send a verification code to your email address, Which you\'ll use to reset your password',
//                     style: TextStyle().copyWith(fontWeight: FontWeight.w500),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: getHeight(context, height: 4),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//               child: EmailField(
//                 focusNode: focusNode,
//                 textInputAction: TextInputAction.done,
//                 prefix: ImageIcon(AssetImage(getPng('email'))),
//                 onSaved: (value) {
//                   resetPwRequest.email = value;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: getHeight(context, height: 2),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//               child: flatButton(() {
//                 validateForm(formKey, () {
//                   Provider.of<AuthProvider>(context)
//                       .sendResetPw(context, resetPwRequest);
//                 });
//               }, 'Continue'),
//             ),
//             SizedBox(
//               height: getHeight(context, height: 4),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
