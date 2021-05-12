import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ddd/common/parameters.dart';
import 'package:flutter_ddd/domain/result/result.dart';
import 'package:flutter_ddd/domain/user/user.dart';
import 'package:flutter_ddd/domain/user/user_repository_base.dart';
import 'package:flutter_ddd/domain/user/value/password/password.dart';
import 'package:flutter_ddd/domain/user/value/username/username.dart';
import 'package:flutter_ddd/helper/keyboard.dart';
import 'package:flutter_ddd/presentation/page/sign_in/sign_in_screen.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

export 'package:flutter_ddd/application/dto/category_dto.dart';


class SignInChangeNotifier with ChangeNotifier {
  String _error='';
  bool _loading=false;
  String _email='';
  String _password='';
  final List<String> _errors=[];

  String getEmail()=>_email;

  void setEmail({required String email})=>_email=email;

  String getPassword()=>_password;

  void setPassword({String? password})=>_password=password!;

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

  List<String> getErrors()=>_errors;

  void setError({
    required String error
  }){
    _error=error;
    notifyListeners();
  }

  String getError()=>_error;

  void setLoading({required bool loading}) {
    _loading = loading;
  }

  bool getLoading()=>_loading;

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
              Navigator.pop(context,SignInResult.success);
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
    try {
      final g=await _googleSignIn.signIn();
      final r=await context.read<UserRepositoryBase>().googleLogIn(g!.id,context);
      r.fold(
        (Result re){
            setError(error: re.message.value);
          },
        (User user){
          context.read<UserRepositoryBase>().setUser(user);
          Navigator.pop(context,SignInResult.success);
        }
      );
    } catch (error) {
      setError(error: error.toString());
    }
    setLoading(loading: false);
  }

  Future validateForm(GlobalKey<FormState> formKey,BuildContext context)async{
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // if all are valid then go to success screen
      KeyboardUtil.hideKeyboard(context);
      setLoading(loading: true);
      setError(error: '');
      final result=await context.read<UserRepositoryBase>().checkUser(
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
          Navigator.pop(context,SignInResult.success);
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