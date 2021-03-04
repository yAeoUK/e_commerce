import 'package:flutter/material.dart';
import 'package:flutter_ddd/domain/result/result.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:flutter_ddd/domain/user/user_repository_base.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_ddd/infrastructure/db_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../components/custom_surfix_icon.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';
import '../../../../helper/keyboard.dart';
import '../../../../parameters.dart';
import '../../../../size_config.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../sign_in_screen.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];
  bool loading=false;
  String apiMessage='';

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
          Row(
            children: [
              // Checkbox(
              //   value: remember,
              //   activeColor: kPrimaryColor,
              //   onChanged: (value) {
              //     setState(() {
              //       remember = value;
              //     });
              //   },
              // ),
              // //Text("Remember me"),
              // Text(AppLocalizations.of(context).rememberMe),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  //"Forgot Password",
                  AppLocalizations.of(context).forgotPassword,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            //text: "Continue",
            text:AppLocalizations.of(context).conTinue,
            press: () async{
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                final result=await context.read<UserRepositoryBase>().checkUser(
                  Username(email),
                  Password(password),
                  context
                );
                result.fold(
                  (Result resul){
                    setState(() {
                      apiMessage=resul.message.value;
                      context.read<DbHelper>().execute(resul.sql);
                    });
                  },
                  (User user){
                    context.read<UserRepositoryBase>().setUser(user);
                    //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                    Navigator.pop(context,SignInScreen.signInSucceed);
                  }
                );
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Visibility(
            visible: loading,
            child: const CircularProgressIndicator(),
          ),
          Visibility(
            visible: apiMessage.isNotEmpty,
            child: Text(apiMessage),
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).pleaseEnterYourPassword);
        } else if (value.length >= 8) {
          removeError(error: AppLocalizations.of(context).passwordTooShort);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: AppLocalizations.of(context).pleaseEnterYourPassword);
          return '';
        } else if (value.length < 8) {
          addError(error: AppLocalizations.of(context).passwordTooShort);
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
          removeError(error: AppLocalizations.of(context).pleaseEnterEmail);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: AppLocalizations.of(context).pleaseEnterValidEmail);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: AppLocalizations.of(context).pleaseEnterEmail);
          return '';
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: AppLocalizations.of(context).pleaseEnterValidEmail);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).email,//"Email",
        hintText: AppLocalizations.of(context).enterYourEmail,//"Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/Mail.svg'),
      ),
    );
  }
}