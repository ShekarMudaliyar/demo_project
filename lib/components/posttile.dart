import 'package:demo_project/models/postsmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostListTile extends StatelessWidget {
  final Post post;
  final Function? onTap;
  const PostListTile({
    Key? key,
    this.onTap,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title as String,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              post.body as String,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ));
  }
}
