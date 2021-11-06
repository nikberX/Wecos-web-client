import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'features/authorization/presentation/authorization_page.dart';

void main() async {
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp(
      ),
      
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        showSemanticsDebugger: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: ThemeData(),
        initialRoute: '/authorization',
        routes: {
          '/' : (ctx) => AuthorizationPage(),
          '/authorization' : (ctx) => AuthorizationPage(),
        },
    );
  }
}
