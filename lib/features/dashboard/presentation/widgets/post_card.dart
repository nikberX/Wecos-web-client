import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/utils/app_colors.dart';
import 'package:wecos_forum/features/dashboard/domain/entity/post.dart';
import 'package:wecos_forum/features/view_post/domain/repositories/viewpost_repository.dart';
import 'package:wecos_forum/features/view_post/presentation/bloc/viewpost_bloc.dart';
import 'package:wecos_forum/features/view_post/presentation/post_page.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => BlocProvider(
              create: (context) =>
                  ViewPostBloc(GetIt.I.get<ViewPostRepository>()),
              child: PostPage(postId: post.id),
            ),
            settings: RouteSettings(name: '/post/${post.id}'),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 350,
        ),
        width: 450,
        decoration: BoxDecoration(
          color: AppColor.cardBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(post.imageUrl),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.black45,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              post.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Text(
                            post.content,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Author : ${post.authorName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => PostPage(postId: post.id),
                                    settings: RouteSettings(
                                        name: '/post/${post.id}')),
                              );
                            },
                            icon: Icon(
                              Icons.comment,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
