import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../components/custom_surfix_icon.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';
import '../../../../presentation/page/otp/otp_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String address;

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
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
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            //text: "continue",
            text: AppLocalizations.of(context)!.conTinue,
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kAddressNullError);
          removeError(error: AppLocalizations.of(context)!.pleaseEnterAddress);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          //addError(error: kAddressNullError);
          addError(error: AppLocalizations.of(context)!.pleaseEnterAddress);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        //labelText: "Address",
        labelText: AppLocalizations.of(context)!.address,
        //hintText: "Enter your phone address",
        hintText: AppLocalizations.of(context)!.enterYourAddress,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            const CustomSurffixIcon(svgIcon: 'assets/icons/Location point.svg'),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kPhoneNumberNullError);
          removeError(error: AppLocalizations.of(context)!.pleaseEnterPhoneNumber);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          //addError(error: kPhoneNumberNullError);
          addError(error: AppLocalizations.of(context)!.pleaseEnterPhoneNumber);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        //labelText: "Phone Number",
        labelText: AppLocalizations.of(context)!.phoneNumber,
        //hintText: "Enter your phone number",
        hintText: AppLocalizations.of(context)!.enterYourPhoneNumber,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/Phone.svg'),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue!,
      decoration: InputDecoration(
        //labelText: "Last Name",
        labelText: AppLocalizations.of(context)!.lastName,
        //hintText: "Enter your last name",
        hintText: AppLocalizations.of(context)!.enterYourLastName,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/User.svg'),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kNamelNullError);
          removeError(error: AppLocalizations.of(context)!.pleaseEnterName);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppLocalizations.of(context)!.pleaseEnterName);
          return '';
        }
        return null;
      },
      decoration: InputDecoration(
        //labelText: "First Name",
        labelText: AppLocalizations.of(context)!.firstName,
        //hintText: "Enter your first name",
        hintText: AppLocalizations.of(context)!.enterYourFirstName,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSurffixIcon(svgIcon: 'assets/icons/User.svg'),
      ),
    );
  }
}