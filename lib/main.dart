import 'package:flutter/material.dart';
import 'package:flutter_ddd/helper/device_info.dart';
import 'package:flutter_ddd/helper/shared_preferences_helper.dart';
import 'package:flutter_ddd/infrastructure/user/data_source/api.dart';
import 'package:flutter_ddd/infrastructure/user/user_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'application/category_app_service.dart';
import 'common/init.dart';
import 'common/parameters.dart';
import 'common/routes.dart';
import 'common/size_config.dart';
import 'common/theme.dart';
import 'domain/user/user_repository_base.dart';
import 'helper/db_helper.dart';
import 'infrastructure/category/category_factory.dart';
import 'infrastructure/category/category_repository.dart';
import 'infrastructure/note/note_repository.dart';
import 'presentation/notifier/category_notifier.dart';
import 'presentation/page/init.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DbHelper>(
          create: (_) => DbHelper(),
          dispose: (_, helper) async => await helper.dispose(),
        ),
        Provider<DeviceInfoHelper>(
          create: (_)=>DeviceInfoHelper(),
        ),
        Provider<SharedPreferencesHelper>(
          create: (_) =>SharedPreferencesHelper() ,
          dispose: (_, helper) async => helper.dispose(),
        ),
        Provider<Api>(
          create: (_)=>Api(),
        ),
        Provider<UserRepositoryBase>(
          create: (context)=>UserRepository(
              sharedPreferencesHelper: context.read<SharedPreferencesHelper>(),
              api: context.read<Api>()
          ),
        ),
        Provider<CategoryRepositoryBase>(
          create: (context) => CategoryRepository(
            dbHelper: context.read<DbHelper>(),
          ),
        ),
        Provider<NoteRepositoryBase>(
          create: (context) => NoteRepository(
            dbHelper: context.read<DbHelper>(),
          ),
        ),
        ChangeNotifierProvider<CategoryNotifier>(
          create: (context) => CategoryNotifier(
            app: CategoryAppService(
              factory: const CategoryFactory(),
              repository: context.read<CategoryRepositoryBase>(),
              noteRepository: context.read<NoteRepositoryBase>(),
            ),
          ),
        ),
        Provider<AppInit>(
          create: (context) => AppInit(context,
              navigatorKey: GlobalKey<NavigatorState>(),
              dbHelper: context.read<DbHelper>(),
              preferencesHelper: context.read<SharedPreferencesHelper>(),
              userRepositoryBase: context.read<UserRepositoryBase>(),
              deviceInfo: context.read<DeviceInfoHelper>()
          ),
        ),
      ], child: const _Init(),
    );
  }
}

class _Init extends StatelessWidget {
  const _Init();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SUPPORTED_LOCALES,
      onGenerateTitle:(c)=>
      AppLocalizations.of(c)!.appName,
      //title: AppLocalizations.of(context)!.appName,
      theme: theme(),
      navigatorKey: Provider.of<AppInit>(context).navigatorKey,
      routes: routes,
      onGenerateRoute: (_) {
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext buildContext) {
            Provider.of<AppInit>(context).materialInitialise(buildContext);
            return InitPage(appTitle: AppLocalizations.of(buildContext)!.appName,);
          }
        );
      },
      //home:const _Init(),
    );
  }
}