import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/page/profile/profile_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../components/coustom_bottom_nav_bar.dart';
import '../../../common/enums.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileNotifier>(
      create:(context)=> ProfileNotifier(),
      child: Scaffold(
        appBar: AppBar(
          //title: Text("Profile"),
          title: Text(AppLocalizations.of(context)!.profile),
        ),
        body: Body(),
        bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.profile),
      ),
    );
  }
}
