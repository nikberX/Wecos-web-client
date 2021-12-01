//import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/constants/app_constants.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/core/utils/app_colors.dart';
import 'package:wecos_forum/features/dashboard/presentation/bloc/posts_bloc.dart';
import 'package:wecos_forum/features/dashboard/presentation/widgets/post_card.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
      floatingActionButton: Container(
        width: 200,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: MaterialButton(
          onPressed: () async {},
          child: Row(
            children: [
              Icon(Icons.add),
              Text('Create post'),
            ],
          ),
          color: AppColor.greenSand,
        ),
      ),
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
                child: BlocBuilder<PostsBloc, PostsState>(
                  builder: (context, state) {
                    GetIt.I.get<Logger>().info('Bloc', state.runtimeType);
                    if (state is PostsSuccessState) {
                      GetIt.I.get<Logger>().info('Success post', 'build');
                      return CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (ctx, index) =>
                                  PostCard(post: state.posts[index]),
                              childCount: state.posts.length,
                            ),
                          )
                        ],
                      );
                    }
                    if (state is PostsLoadingMoreState) {
                      return CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (ctx, index) =>
                                  PostCard(post: state.posts[index]),
                              childCount: state.posts.length,
                            ),
                          )
                        ],
                      );
                    }
                    if (state is PostsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
