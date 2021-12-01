//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wecos_forum/core/constants/app_constants.dart';
import 'package:wecos_forum/core/utils/app_colors.dart';
import 'package:wecos_forum/features/authorization/presentation/bloc/auth_bloc.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  bool sign_in = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
  }

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
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(''),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Url картинки',
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Название поста'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        maxLines: 50,
                        maxLength: 150,
                        decoration: InputDecoration(hintText: 'Текст'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text('Создать'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
