import 'package:demo_project/bloc/posts_bloc.dart';
import 'package:demo_project/components/posttile.dart';
import 'package:demo_project/homepage/createpost.dart';
import 'package:demo_project/models/postsmodel.dart';
import 'package:demo_project/models/usersmodel.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  final Users user;
  const PostPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final postsBloc = PostsBloc();

  @override
  void initState() {
    super.initState();
    //set current user for the instance
    postsBloc.setCurretUserEventSink.add(widget.user);

    //fetch posts of current user
    postsBloc.eventSink.add(PostsAction.Fetch);
  }

  @override
  void dispose() {
    //disposing post bloc
    postsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      //button to add a post for the user
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          //navigation to create post page and sending current user and postsBloc instance
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CreatePost(
                    postsBloc: postsBloc,
                    user: widget.user,
                  )))),
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: StreamBuilder<List<Post>>(
          stream: postsBloc.postStream,
          builder: (context, snapshot) {
            //if stream got any errors
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error as String),
              );
            }

            //if service is running
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            //when stream gets the data
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      PostListTile(post: snapshot.data![index]));
            } else {
              return Container();
            }
          }),
    );
  }
}
