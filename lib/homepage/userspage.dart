import 'package:demo_project/bloc/users_bloc.dart';
import 'package:demo_project/components/usertile.dart';
import 'package:demo_project/homepage/postspage.dart';
import 'package:demo_project/models/usersmodel.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersBloc = UsersBloc();
  @override
  void initState() {
    super.initState();
    //event to fetch users
    usersBloc.eventSink.add(UsersAction.Fetch);
  }

  @override
  void dispose() {
    //disposing users bloc
    usersBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: StreamBuilder<List<Users>>(
          stream: usersBloc.userStream,
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
                  itemBuilder: (context, index) => UserListTile(
                      user: snapshot.data![index],
                      onTap: () {
                        //navigating to posts list page
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => PostPage(
                                  user: snapshot.data![index],
                                )));
                      }));
            } else {
              return Container();
            }
          }),
    );
  }
}
