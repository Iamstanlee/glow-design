// import 'package:flutter/material.dart';
// import 'package:lendly/bloc/auth_bloc.dart';
// import 'package:lendly/data/network/request/changepassword_request.dart';
// import 'package:lendly/data/network/request/resetpassword_request.dart';
// import 'package:lendly/helpers/base_field.dart';
// import 'package:lendly/helpers/functions.dart';
// import 'package:lendly/theme.dart';
// import 'package:lendly/widgets/button/flat_button.dart';
// import 'package:provider/provider.dart';

// class ResetPassword extends StatefulWidget {
//   final ResetPwRequest resetPwRequest;
//   ResetPassword(this.resetPwRequest);
//   @override
//   _ResetPasswordState createState() => _ResetPasswordState();
// }

// class _ResetPasswordState extends State<ResetPassword> {
//   var formKey = GlobalKey<FormState>();
//   bool obscurePw = true;
//   FocusNode codeNode = FocusNode();
//   FocusNode pwNode = FocusNode();
//   ChangePwRequest changePwRequest = ChangePwRequest();
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
//               child: Text('Reset Password',
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
//                     'Enter the verification code sent to ',
//                     style: TextStyle().copyWith(fontWeight: FontWeight.w500),
//                   ),
//                   Text('${widget.resetPwRequest.email}',
//                       style: TextStyle().copyWith(
//                           color: primaryColor,
//                           fontFamily: primaryFont,
//                           fontWeight: FontWeight.w800))
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: getHeight(context, height: 4),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//               child: RegField(
//                 labelText: 'VERIFICATION CODE',
//                 keyboardType: TextInputType.number,
//                 focusNode: codeNode,
//                 textInputAction: TextInputAction.next,
//                 onFieldSubmitted: (value) {
//                   FocusScope.of(context).requestFocus(pwNode);
//                 },
//                 prefix: ImageIcon(AssetImage(getPng('user_small'))),
//                 onSaved: (value) {
//                   changePwRequest.code = value;
//                   changePwRequest.email = widget.resetPwRequest.email;
//                 },
//               ),
//             ),
//             SizedBox(
//               height: getHeight(context, height: 2),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//               child: PasswordField(
//                 focusNode: pwNode,
//                 onChanged: (value) {},
//                 textInputAction: TextInputAction.done,
//                 obscureText: obscurePw,
//                 obscure: () {
//                   setState(() {
//                     obscurePw = !obscurePw;
//                   });
//                 },
//                 prefix: ImageIcon(AssetImage(getPng('lock'))),
//                 onSaved: (value) {
//                   changePwRequest.password = value;
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
//                       .changePw(context, changePwRequest);
//                 });
//               }, 'Reset'),
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
