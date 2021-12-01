//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                            bottomLeft: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                          color: Colors.black26),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            tr('welcome_to_wecos'),
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedSize(
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        width: 300,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.cardBackground,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          children: [
                            Form(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: tr('email'),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  TextField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      hintText: tr('password'),
                                    ),
                                  ),
                                  if (!sign_in) const SizedBox(height: 15),
                                  if (!sign_in)
                                    TextField(
                                      controller: _repeatPasswordController,
                                      decoration: InputDecoration(
                                        hintText: tr('repeat_password'),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoadingState) {
                                  return Container(
                                    height: 53,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: AppColor.sand,
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {},
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  height: 53,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: AppColor.sand),
                                  child: MaterialButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(context).add(
                                        sign_in
                                            ? AuthLoginEvent(
                                                _emailController.text,
                                                _passwordController.text,
                                              )
                                            : AuthRegisterEvent(
                                                _emailController.text,
                                                _passwordController.text,
                                              ),
                                      );
                                    },
                                    child: Text(
                                      sign_in ? tr('sign_in') : tr('sign_up'),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                  ),
                                ),
                                Text(
                                  tr('or'),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Spacer(),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthLoadingState) {
                                      return Container(
                                        height: 27,
                                        width: 135,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          color: AppColor.greenSand,
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {},
                                          child: Container(),
                                        ),
                                      );
                                    }
                                    return Container(
                                      height: 27,
                                      width: 135,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        color: AppColor.greenSand,
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            sign_in = !sign_in;
                                          });
                                        },
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            sign_in
                                                ? tr('sign_up')
                                                : tr('i_have_account'),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthErrorState) {
                          return Container(
                            height: 53,
                            width: 300,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColor.yellowError,
                                width: 2,
                              ),
                              color: AppColor.yellowError.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                state.error,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
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
