
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wecos_forum/core/utils/app_colors.dart';

class AuthorizationPage extends StatefulWidget {

  const AuthorizationPage({ Key? key }) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  bool sign_in = true;

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
                        color: Colors.black26
                      ),
                      child: Center(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              tr('welcome_to_wecos'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                              ),
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
                                  TextField(),
                                  const SizedBox(height: 15),
                                  TextField(),
                                  if (!sign_in) const SizedBox(height: 15),
                                  if (!sign_in) TextField(),
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
                                child: Text(
                                  sign_in ? tr('sign_in') : tr('sign_up'),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(height: 1, color: Colors.grey, margin: const EdgeInsets.symmetric(horizontal: 5),),
                                ),
                                Text(tr('or'),style: TextStyle(color: Colors.grey),),
                                Expanded(
                                  child: Container(height: 1, color: Colors.grey, margin: const EdgeInsets.symmetric(horizontal: 5),),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Spacer(),
                                Container(
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
                                        sign_in ? tr('sign_up') : tr('i_have_account'),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
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