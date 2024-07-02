// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../components/alerts.dart';
import '../../../components/crud.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constant/linkapi.dart';
import '../../../constants.dart';
// import '../../../helper/keyboard.dart';
// import '../../forgot_password/forgot_password_screen.dart';
import '../../../main.dart';
import '../../login_success/login_success_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Crud _crud = Crud();
  bool isLoading = false;

  loginUser() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var responce = await _crud.postRequests(linkLogin, {
        'email': email,
        'password': password,
      });
      isLoading = false;
      setState(() {});
      if (responce['status'] == 'success') {
        sharedPref.setString(
            'CUSTOMERID', responce['data']['CUSTOMERID'].toString());
        sharedPref.setString('CUSUNAME', responce['data']['CUSUNAME']);
        sharedPref.setString('FNAME', responce['data']['FNAME']);
        sharedPref.setString('CITYADD', responce['data']['CITYADD']);
        sharedPref.setString('EMAILADD', responce['data']['EMAILADD']);
        sharedPref.setString('PHONE', responce['data']['PHONE'].toString());
        sharedPref.setString(
            'CUSPHOTO', responce['data']['CUSPHOTO'].toString());
                   sharedPref.setString(
            'CUSPASS', responce['data']['CUSPASS'].toString());

        return Navigator.of(context).pushNamedAndRemoveUntil(
            LoginSuccessScreen.routeName, (route) => false);
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertFailed(
              message: "Login Faild ",
              // routename: "login",
            );
          },
        );
      }
    } else {
      print("Form not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              email = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 2) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          // Row(
          //   children: [
          //     Checkbox(
          //       value: remember,
          //       activeColor: kPrimaryColor,
          //       onChanged: (value) {
          //         setState(() {
          //           remember = value;
          //         });
          //       },
          //     ),
          //     // const Text("Remember me"),
          //     // const Spacer(),
          //     // GestureDetector(
          //     //   onTap: () => Navigator.pushNamed(
          //     //       context, ForgotPasswordScreen.routeName),
          //     //   child: const Text(
          //     //     "Forgot Password",
          //     //     style: TextStyle(decoration: TextDecoration.underline),
          //     //   ),
          //     // )
          //   ],
          // ),
          FormError(errors: errors),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await loginUser();
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();
              //   // if all are valid then go to success screen
              //   KeyboardUtil.hideKeyboard(context);
              //   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              // }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
