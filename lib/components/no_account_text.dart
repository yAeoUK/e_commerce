import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/parameters.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_ddd/presentation/page/sign_in/sign_in_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../presentation/page/sign_up/sign_up_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
     Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.dontHaveAnAccount,
          //"Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () async{
            var result=await Navigator.pushNamed(context, SignUpScreen.routeName);
            if(result==SignUpResult.success){
                Navigator.pop(context,SignInResult.success);
                }
              },
          child: Text(
            //"Sign Up",
            AppLocalizations.of(context)!.signUp,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
