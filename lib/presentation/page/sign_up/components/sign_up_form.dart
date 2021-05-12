import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_ddd/presentation/page/sign_up/sign_up_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../components/custom_surfix_icon.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;
  late String error;
  bool remember = false;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    email=context.select((SignUpChangeNotifier value) => value.getEmail());
    password=context.select((SignUpChangeNotifier value) => value.getPassword());
    confirmPassword=context.select((SignUpChangeNotifier value) => value.getConfirmPassword());
    error=context.select((SignUpChangeNotifier value) => value.getError());
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
            text: AppLocalizations.of(context)!.conTinue,
            press: () {
              context.read<SignUpChangeNotifier>().validateForm(_formKey, context);
              // if (_formKey.currentState.validate()) {
              //   _formKey.currentState.save();
              //   // if all are valid then go to success screen
              //   Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              // }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Visibility(
            visible: context.select((SignUpChangeNotifier value) => value.getLoading()),
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => context.read<SignUpChangeNotifier>().setConfirmPassword(confirmPassword: newValue!),
      onChanged: (value) {
        context.read<SignUpChangeNotifier>().onConfirmPasswordChanged(value, context);
      },
      validator: (value) {
        return context.read<SignUpChangeNotifier>().validateConfirmPassword(value!,context);
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.confirmPassword,//"Confirm Password",
        hintText: AppLocalizations.of(context)!.reenterYourPassword,//"Re-enter your password",
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
      onSaved: (newValue) => context.read<SignUpChangeNotifier>().setPassword(password: newValue!),
      onChanged: (value) {
        context.read<SignUpChangeNotifier>().onPasswordChanged(value, context);
      },
      validator: (value) {
        return context.read<SignUpChangeNotifier>().validatePassword(value!, context);
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
      onSaved: (newValue) => context.read<SignUpChangeNotifier>().setEmail(email: newValue!),
      onChanged: (value) {
        context.read<SignUpChangeNotifier>().onEmailChanged(value, context);
      },
      validator: (value) {
        return context.read<SignUpChangeNotifier>().validateEmail(value!, context);
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.email,//"Email",
        hintText: AppLocalizations.of(context)!.pleaseEnterEmail,//"Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/Mail.svg'),
      ),
    );
  }
}
