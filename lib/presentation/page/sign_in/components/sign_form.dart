import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_ddd/presentation/page/sign_in/sign_in_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../components/custom_surfix_icon.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    final String error=context.select((SignInChangeNotifier value) => value.getError());
    errors=context.select((SignInChangeNotifier value) => value.getErrors());
    email=context.select((SignInChangeNotifier value) => value.getEmail());
    password=context.select((SignInChangeNotifier value) => value.getPassword());
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
              // Text(AppLocalizations.of(context)!.rememberMe),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  //"Forgot Password",
                  AppLocalizations.of(context)!.forgotPassword,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            //text: "Continue",
            text:AppLocalizations.of(context)!.conTinue,
            press: () {
              context.read<SignInChangeNotifier>().validateForm(_formKey,context);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Visibility(
            visible: context.select((SignInChangeNotifier value) => value.getLoading()),
            child: const CircularProgressIndicator(),
          ),
          Visibility(
            visible: error.isNotEmpty,
            child: Text(error),
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => context.read<SignInChangeNotifier>().setPassword(password: newValue),
      onChanged: (value) {
        context.read<SignInChangeNotifier>().onPasswordChanged(value,context);
        //return '';
      },
      validator: (value) {
        return context.read<SignInChangeNotifier>().validatePassword(value!,context);
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.password,//"Password",
        hintText: AppLocalizations.of(context)!.enterYourPassword,//"Enter your password",
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
      onSaved: (newValue) => context.read<SignInChangeNotifier>().setEmail(email: newValue!),
      onChanged: (value) {
        context.read<SignInChangeNotifier>().onEmailChanged(value,context);
      },
      validator: (value) {
        return context.read<SignInChangeNotifier>().validateEmail(value!,context);
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.email,//"Email",
        hintText: AppLocalizations.of(context)!.enterYourEmail,//"Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/Mail.svg'),
      ),
    );
  }
}