import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/parameters.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../components/custom_surfix_icon.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';
import '../../../../components/no_account_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight!* 0.04),
              Text(
                //"Forgot Password",
                AppLocalizations.of(context)!.forgotPassword,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.enterEmailToRecoverPassword,
                //"Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight!* 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue!,
            onChanged: (value) {
              //if (value.isNotEmpty && errors.contains(kEmailNullError)) {
              if (value.isNotEmpty && errors.contains(AppLocalizations.of(context)!.pleaseEnterEmail)) {
                setState(() {
                  errors.remove(AppLocalizations.of(context)!.pleaseEnterEmail);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(AppLocalizations.of(context)!.pleaseEnterValidEmail)){
                setState(() {
                  errors.remove(AppLocalizations.of(context)!.pleaseEnterValidEmail);
                });
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(AppLocalizations.of(context)!.pleaseEnterEmail)) {
                setState(() {
                  errors.add(AppLocalizations.of(context)!.pleaseEnterEmail);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(AppLocalizations.of(context)!.pleaseEnterValidEmail)) {
                setState(() {
                  errors.add(AppLocalizations.of(context)!.pleaseEnterValidEmail);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.email,//Email",
              hintText: AppLocalizations.of(context)!.enterYourEmail,//"Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/Mail.svg'),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight!* 0.1),
          DefaultButton(
            text: AppLocalizations.of(context)!.conTinue,//"Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                // Do what you want to do
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight!* 0.1),
          const NoAccountText(),
        ],
      ),
    );
  }
}
