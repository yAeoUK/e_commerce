import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../components/custom_surfix_icon.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';
import '../../../../parameters.dart';
import '../../../../size_config.dart';
import '../../complete_profile/complete_profile_screen.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String conformPassword;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            //text: "Continue",
            text: AppLocalizations.of(context).conTinue,
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).pleaseEnterYourPassword);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: AppLocalizations.of(context).passwordsDontMatch);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: AppLocalizations.of(context).pleaseEnterYourPassword);
          return '';
        } else if (password != value) {
          addError(error: AppLocalizations.of(context).passwordsDontMatch);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).confirmPassword,//"Confirm Password",
        hintText: AppLocalizations.of(context).reenterYourPassword,//"Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/Lock.svg'),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).pleaseEnterYourPassword);//kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: AppLocalizations.of(context).passwordTooShort);//kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: AppLocalizations.of(context).pleaseEnterYourPassword);//kPassNullError);
          return '';
        } else if (value.length < 8) {
          addError(error: AppLocalizations.of(context).passwordTooShort);//kShortPassError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).password,//"Password",
        hintText: AppLocalizations.of(context).enterYourPassword,//"Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/Lock.svg'),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).pleaseEnterEmail);//kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: AppLocalizations.of(context).pleaseEnterValidEmail);//kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: AppLocalizations.of(context).pleaseEnterEmail);//kEmailNullError);
          return '';
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: AppLocalizations.of(context).pleaseEnterValidEmail);//kInvalidEmailError);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).email,//"Email",
        hintText: AppLocalizations.of(context).pleaseEnterEmail,//"Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/Mail.svg'),
      ),
    );
  }
}
