import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: AppLocalizations.of(context).myAccount,//"My Account",
            icon: 'assets/icons/User Icon.svg',
            press: () {},
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).notifications,//"Notifications",
            icon: 'assets/icons/Bell.svg',
            press: () {},
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).settings,//"Settings",
            icon: 'assets/icons/Settings.svg',
            press: () {},
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).helpCenter,//"Help Center",
            icon: 'assets/icons/Question mark.svg',
            press: () {},
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).logOut,//"Log Out",
            icon: 'assets/icons/Log out.svg',
            press: () {},
          ),
        ],
      ),
    );
  }
}
