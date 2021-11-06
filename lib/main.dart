import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            child: Image.asset('assets/images/png/background.png'),
            fit: BoxFit.fill,
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.black26
                      ),
                      child: Center(
                          child: Text(
                            tr('welcome_to_wecos'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22
                            ),
                          ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            tr('sign_in'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}