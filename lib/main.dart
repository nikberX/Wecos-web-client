import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/service/api/api.dart';
import 'package:wecos_forum/core/service/http_client.dart/http_client.dart';
import 'package:wecos_forum/core/service/log_service/log_strategies/console_log_strategy.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/features/authorization/domain/repositories/user_repository.dart';
import 'features/authorization/presentation/authorization_page.dart';
import 'features/authorization/presentation/bloc/auth_bloc.dart';

void main() async {
  GetIt.I.registerSingleton<Logger>(Logger(logStrategy: ConsoleLogStrategy()));
  GetIt.I.registerSingleton<HttpClient>(HttpClient());
  GetIt.I.registerSingleton<Api>(Api(GetIt.I.get<HttpClient>()));
  GetIt.I.registerSingleton<UserRepository>(UserRepository(GetIt.I.get<Api>()));
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        '/': (ctx) => BlocProvider(
              create: (context) => AuthBloc(GetIt.I.get<UserRepository>()),
              child: AuthorizationPage(),
            ),
        '/authorization': (ctx) => BlocProvider(
              create: (context) => AuthBloc(GetIt.I.get<UserRepository>()),
              child: AuthorizationPage(),
            ),
        //'/posts' : (ctx) => DashboardPage(),
      },
    );
  }
}
