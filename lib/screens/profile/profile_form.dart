// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shop_app/components/alerts.dart';
import 'package:shop_app/components/crud.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../components/form_error.dart';
import '../../../constant/linkapi.dart';
import '../../../constants.dart';
import '../../main.dart';
import '../init_screen.dart';

class ProfileDetailsForm extends StatefulWidget {
  const ProfileDetailsForm({super.key});

  @override
  _ProfileDetailsFormState createState() => _ProfileDetailsFormState();
}

class _ProfileDetailsFormState extends State<ProfileDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  String? fullname;
  String? username;
  String? phone;
  String? address;
  String? email;
  String? password;
  String? user_id;

  bool remember = false;
  final List<String?> errors = [];

  @override
  void initState() {
    user_id = sharedPref.getString('CUSTOMERID').toString();
    fullname = sharedPref.getString('FNAME').toString();
    username = sharedPref.getString('CUSUNAME').toString();
    phone = sharedPref.getString('PHONE').toString();
    address = sharedPref.getString('CITYADD').toString();
    email = sharedPref.getString('EMAILADD').toString();
    password = sharedPref.getString('CUSPASS').toString();

    super.initState();
  }

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

  UpdateProfile() async {
    if (_formKey.currentState!.validate()) {
      // print(username);
      // print(fullname);
      // print(email);
      // print(phone);
      // print(address);
      // print(password);
      // print(user_id);

      isLoading = true;
      setState(() {});
      var responce = await _crud.postRequests(linkupdateProfile, {
        "username": username,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "address": address,
        "password": password,
        "user_id": user_id
      });
      isLoading = false;
      setState(() {});
      if (responce['status'] == "success") {
        // Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
        return showDialog(
          context: context,
          builder: (context) {
            return AlertSuccess(
              message: "Updated",
              routename: InitScreen.routeName,
            );
          },
        );
      }
      if (responce['status'] == "Exist") {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertWarning(
              message: "This User Exist",
            );
          },
        );
      } else {
        print("Sign up feild");
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: isLoading == true
          ? Center(child: Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                TextFormField(
                  initialValue: fullname,
                  keyboardType: TextInputType.name,
                  onSaved: (newValue) => fullname = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kfullnameNullError);
                    } else if (value.length < 2) {
                      removeError(error: "full Name too Short");
                    }
                    fullname = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: kfullnameNullError);
                      return "";
                    } else if (value.length < 2) {
                      addError(error: "full Name too Short");
                      return "";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    hintText: "Enter Full Name",

                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.person_pin_circle_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: username,
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => username = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kusernameNullError);
                    } else if (value.length < 2) {
                      removeError(error: "User Name too Short");
                    }
                    username = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: kusernameNullError);
                      return "";
                    } else if (value.length < 2) {
                      addError(error: "User Name too Short");
                      return "";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "User Name",
                    hintText: "Enter User Name",
                    focusColor: Colors.black,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: address,
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => address = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kAddressNullError);
                    } else if (value.length < 2) {
                      removeError(error: "Address too Short");
                    }
                    address = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: kAddressNullError);
                      return "";
                    } else if (value.length < 2) {
                      addError(error: "Address too Short");
                      return "";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Address",
                    hintText: "Enter Address",
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.cabin_rounded),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: phone,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => phone = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kPhoneNumberNullError);
                    } else if (value.length < 2) {
                      removeError(error: "phone too Short");
                    }
                    phone = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      addError(error: kPhoneNumberNullError);
                      return "";
                    } else if (value.length < 2) {
                      addError(error: "phone too Short");
                      return "";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    hintText: "Enter Phone",
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: email,
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
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.mail),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: password,
                  obscureText: true,
                  onSaved: (newValue) => password = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kPassNullError);
                    } else if (value.length < 2) {
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
                    suffixIcon: Icon(Icons.lock),
                  ),
                ),
                FormError(errors: errors),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await UpdateProfile();
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
    );
  }
}
