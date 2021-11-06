
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wecos_forum/core/utils/app_colors.dart';

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
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Column(
                        children: [
                          Text(
                            tr('sign_in'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Form(
                            child: Column(
                              children: [
                                TextField(),
                                const SizedBox(height: 15),
                                TextField(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 53,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: AppColor.sand
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(tr('sign_in'),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
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