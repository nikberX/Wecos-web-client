//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/constants/app_constants.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/core/utils/app_colors.dart';
import 'package:wecos_forum/features/authorization/presentation/bloc/auth_bloc.dart';
import 'package:wecos_forum/features/create_post/presentation/bloc/createpostbloc_bloc.dart';
import 'package:wecos_forum/features/view_post/domain/repositories/viewpost_repository.dart';
import 'package:wecos_forum/features/view_post/presentation/bloc/viewpost_bloc.dart';
import 'package:wecos_forum/features/view_post/presentation/post_page.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  bool sign_in = true;

  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlController.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: BlocListener<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state is CreatePostLoadingState) {
            showDialog(
              context: context,
              builder: (_) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          if (state is CreatePostSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                  create: (context) =>
                      ViewPostBloc(GetIt.I.get<ViewPostRepository>()),
                  child: PostPage(postId: state.postId),
                ),
              ),
            );
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              child: Image.asset('assets/images/png/background.png'),
              fit: BoxFit.fill,
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        _imageUrlController.text,
                        errorBuilder: (ctx, _, __) {
                          return Container(
                            width: double.infinity,
                            height: 500,
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.blue1, width: 3),
                                borderRadius: BorderRadius.circular(15),
                                color: AppColor.blue2.withOpacity(0.6)),
                          );
                        },
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: _imageUrlController,
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                onChanged: (_) {
                                  setState(() {});
                                },
                                decoration: inputDecoration('Url картинкик'),
                                validator: (value) => validator(value),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: _titleController,
                                decoration: inputDecoration('Название поста'),
                                validator: (value) => validator(value),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: _contentController,
                                maxLines: 20,
                                maxLength: 150,
                                decoration: inputDecoration('Текст'),
                                validator: (value) => validator(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 53,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.8),
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            var res = formKey.currentState!.validate();
                            if (res) {
                              BlocProvider.of<CreatePostBloc>(context).add(
                                CreatePostEvent(
                                  _imageUrlController.text,
                                  _titleController.text,
                                  _contentController.text,
                                ),
                              );
                            }
                          },
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
      ),
    );
  }

  OutlineInputBorder inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 12,
      ),
      hintText: hintText,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide.none,
      ),
      enabledBorder: inputBorder(Colors.green),
      focusedBorder: inputBorder(Colors.grey),
      errorBorder: inputBorder(Colors.red),
      focusedErrorBorder: inputBorder(Colors.red),
      contentPadding: EdgeInsets.symmetric(
        vertical: 17,
        horizontal: 15,
      ),
    );
  }

  String? validator(String? value) {
    if (value == null) return 'Пустое поле';
    if (value.isEmpty) return 'Пустое поле';
    return null;
  }
}
