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
import 'package:wecos_forum/features/view_post/presentation/bloc/createcomment_bloc.dart';
import 'package:wecos_forum/features/view_post/presentation/bloc/viewpost_bloc.dart';

class PostPage extends StatefulWidget {
  final String postId;
  const PostPage({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool sign_in = true;

  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ViewPostBloc>(context)
        .add(ViewPostLoadEvent(widget.postId));
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _scrollController.dispose();
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
          Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: BlocBuilder<ViewPostBloc, ViewPostState>(
                  builder: (context, state) {
                    if (state is ViewPostSuccessState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(state.post.imageUrl),
                          Container(
                            width: 500,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColor.blue1, width: 4),
                              color: AppColor.blue2.withOpacity(0.5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.post.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.post.content,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...state.post.comments.map(
                            (e) => Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              color: Colors.grey.withOpacity(0.4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      if (e.imageUrl != null)
                                        SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: Image.network(e.imageUrl!),
                                        ),
                                      Text(e.content),
                                    ],
                                  ),
                                  Text(e.username),
                                  Text(e.timestamp.toString()),
                                ],
                              ),
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 300),
                                  child: TextFormField(
                                    controller: _imageUrlController,
                                    decoration: inputDecoration('Комментарий'),
                                    validator: (value) => validator(value),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 300),
                                  child: TextFormField(
                                    onEditingComplete: () {
                                      setState(() {});
                                    },
                                    onChanged: (_) {
                                      setState(() {});
                                    },
                                    controller: _titleController,
                                    decoration:
                                        inputDecoration('Картинка (Url)'),
                                    validator: (value) => validator(value),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          BlocBuilder<CreateCommentBloc, CreateCommentState>(
                            builder: (context, state) {
                              if (state is CreateCommentLoadingState)
                                return Container(
                                  height: 53,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.8),
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              if (state is CreateCommentSuccessState) {
                                BlocProvider.of<ViewPostBloc>(context)
                                    .add(ViewPostLoadEvent(widget.postId));
                                //TODO: REFACTOR HOT FIX
                                BlocProvider.of<CreateCommentBloc>(context)
                                    .add(CreateCommentCrearEvent.empty());
                              }
                              return Container(
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
                                      BlocProvider.of<CreateCommentBloc>(
                                              context)
                                          .add(
                                        CreateCommentEvent(
                                          _imageUrlController.text,
                                          _titleController.text,
                                          widget.postId,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('Оставить комментарий'),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          )
        ],
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
