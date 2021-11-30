import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/service/api/api.dart';
import 'package:wecos_forum/core/service/http_client.dart/dio_interceptors.dart/dio_logger.dart';
import 'package:wecos_forum/core/service/http_client.dart/http_client.dart';
import 'package:wecos_forum/core/service/log_service/log_strategies/console_log_strategy.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/core/utils/app_colors.dart';
import 'package:wecos_forum/features/authorization/domain/repositories/user_repository.dart';
import 'package:wecos_forum/features/dashboard/domain/repositories/posts_repository.dart';
import 'package:wecos_forum/features/dashboard/presentation/bloc/posts_bloc.dart';
import 'package:wecos_forum/features/dashboard/presentation/dashboard_page.dart';
import 'features/authorization/presentation/authorization_page.dart';
import 'features/authorization/presentation/bloc/auth_bloc.dart';

void main() async {
  GetIt.I.registerSingleton<Logger>(Logger(logStrategy: ConsoleLogStrategy()));
  GetIt.I.registerSingleton<HttpClient>(HttpClient());
  GetIt.I.get<HttpClient>().addInterceptor(DioLogger(GetIt.I.get<Logger>()));
  GetIt.I.registerSingleton<Api>(Api(GetIt.I.get<HttpClient>()));
  GetIt.I.registerSingleton<UserRepository>(UserRepository(GetIt.I.get<Api>()));
  GetIt.I
      .registerSingleton<PostsRepository>(PostsRepository(GetIt.I.get<Api>()));
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
      initialRoute: '/',
      routes: {
        '/': (ctx) => BlocProvider(
              create: (context) => PostsBloc(GetIt.I.get<PostsRepository>()),
              child: HomePage(),
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  List<Widget> pages = [DashboardPage(), AuthorizationPage()];

  void _onItemTapped(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: AppColor.cardBackground),
        unselectedIconTheme: IconThemeData(color: AppColor.blue3),
        onTap: (index) async {
          _onItemTapped(index);
        },
        currentIndex: index,
        selectedItemColor: AppColor.blue1,
        unselectedItemColor: AppColor.blue3,
        unselectedFontSize: 0,
        showUnselectedLabels: true,
        backgroundColor: AppColor.sand,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.architecture),
            label: tr('posts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: tr('profile'),
          ),
        ],
      ),
    );
  }
}
