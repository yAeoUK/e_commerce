import 'package:flutter/cupertino.dart';
import 'package:flutter_ddd/common/parameters.dart';
import 'package:flutter_ddd/domain/result/result.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:flutter_ddd/domain/user/user_repository_base.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_ddd/helper/keyboard.dart';
import 'package:flutter_ddd/presentation/page/complete_profile/complete_profile_screen.dart';
import 'package:flutter_ddd/presentation/page/sign_up/sign_up_screen.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpChangeNotifier with ChangeNotifier{
  String _error='';
  bool _loading=false;
  String _email='';
  String _password='';
  String _confirmPassword='';
  final List<String> _errors=[];

  bool getLoading()=>_loading;

  String getError()=>_error;

  String getEmail()=>_email;

  void setEmail({required String email}){
    _email=email;
    notifyListeners();
  }

  String getPassword()=>_password;

  void setPassword({required String password}){
    _password=password;
    notifyListeners();
  }

  String getConfirmPassword()=>_confirmPassword;

  void setConfirmPassword({required String confirmPassword}){
    _confirmPassword=confirmPassword;
    notifyListeners();
  }

  void addError({required String error}) {
    if (!_errors.contains(error)){
      _errors.add(error);
      notifyListeners();
    }
  }

  void removeError({required String error}){
    if (_errors.contains(error)) {
      _errors.remove(error);
      notifyListeners();
    }
  }

  void setLoading({required bool loading}) {
    _loading = loading;
    notifyListeners();
  }

  void setError({required String error}){
    _error=error;
    notifyListeners();
  }

  Future facebookVerification(BuildContext context)async{
    final facebookLogin = FacebookLogin();
    setLoading(loading: true);
    final result = await facebookLogin.logIn([]);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final r=await context.read<UserRepositoryBase>().facebookLogIn(result.accessToken,context);
        r.fold(
          (Result re){
            setError(error: re.message.value);
          },
          (User user){
            context.read<UserRepositoryBase>().setUser(user);
            Navigator.pop(context,SignUpResult.success);
          }
        );
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        setError(error: result.errorMessage);
        break;
    }
    setLoading(loading: false);
  }

  Future googleVerification(BuildContext context)async{
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        //'https://www.googleapis.com/auth/contacts.readonly',
        'https://www.googleapis.com/auth/userinfo.email'
      ],
    );
    setLoading(loading: true);
    final g=await _googleSignIn.signIn();
    final r=await context.read<UserRepositoryBase>().googleLogIn(g!.id,context);
    r.fold(
      (Result re){
        setError(error: re.message.value);
      },
      (User user){
        context.read<UserRepositoryBase>().setUser(user);
        Navigator.pop(context,SignUpResult.success);
      }
    );
    setLoading(loading: false);
  }

  Future validateForm(GlobalKey<FormState> formKey,BuildContext context)async{
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);
      setLoading(loading: true);
      setError(error: '');
      final result=await context.read<UserRepositoryBase>().registerUser(
          Username(_email),
          Password(_password),
          context
      );
      setLoading(loading: false);
      result.fold(
        (Result r){
          setError(error: r.message.value);
        },
        (User user){
          context.read<UserRepositoryBase>().setUser(user);
          Navigator.pop(context,SignUpResult.success);
          // Navigator.pushReplacementNamed(context, CompleteProfileScreen.routeName,result: SignUpResult.success);
        }
      );
    }
  }

  void onPasswordChanged(String value,BuildContext context) {
    if (value.isNotEmpty) {
      removeError(error: AppLocalizations.of(context)!.pleaseEnterYourPassword);
    }
    if (value.length >= Password.minimalLength) {
      removeError(error: AppLocalizations.of(context)!.passwordTooShort);
    }
    setPassword(password: value);
  }

  void onConfirmPasswordChanged(String value,BuildContext context) {
    if (value.isNotEmpty) {
      removeError(error: AppLocalizations.of(context)!.pleaseConfirmPassword);
    }
    if (value.length >= Password.minimalLength) {
      removeError(error: AppLocalizations.of(context)!.passwordTooShort);
    }
    setConfirmPassword(confirmPassword: value);
  }

  String? validatePassword(String value, BuildContext context) {
    String error='';
    if (value.isEmpty) {
      error=AppLocalizations.of(context)!.pleaseEnterYourPassword;
      //return '';
    }
    if (value.length < Password.minimalLength) {
      error=AppLocalizations.of(context)!.passwordTooShort;
      //return '';
    }
    if(error!='') {
      addError(error: error);
      return error;
    }
    return null;
  }

  String? validateConfirmPassword(String value,BuildContext context){
    if (value.isEmpty) {
      addError(error: AppLocalizations.of(context)!.pleaseConfirmPassword);
      return '';
    } else if (_password != value) {
      addError(error: AppLocalizations.of(context)!.passwordsDontMatch);
      return '';
    }
    return null;
  }

  void onEmailChanged(String value, BuildContext context) {
    if (value.isNotEmpty) {
      removeError(error: AppLocalizations.of(context)!.pleaseEnterEmail);
    }
    if (emailValidatorRegExp.hasMatch(value)) {
      removeError(error: AppLocalizations.of(context)!.pleaseEnterValidEmail);
    }
    setEmail(email: value);
  }

  String? validateEmail(String value, BuildContext context) {
    String error='';
    if (value.isEmpty) {
      error=AppLocalizations.of(context)!.pleaseEnterEmail;
      addError(error: error);
      return error;
    }
    if (!emailValidatorRegExp.hasMatch(value)) {
      error=AppLocalizations.of(context)!.pleaseEnterValidEmail;
      addError(error: error);
      return error;
    }
    return null;
  }

}