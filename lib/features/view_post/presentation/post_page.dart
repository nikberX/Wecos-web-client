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
    BlocProvider.of<ViewPostBloc>(context)
        .add(ViewPostLoadEvent(widget.postId));
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
