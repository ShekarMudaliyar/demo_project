import 'package:demo_project/bloc/posts_bloc.dart';
import 'package:demo_project/models/usersmodel.dart';
import 'package:demo_project/services/api_service.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  final PostsBloc postsBloc;
  final Users user;
  const CreatePost({Key? key, required this.postsBloc, required this.user})
      : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  //controllers for text fields
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //flag for loading state
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          labelText: "Post Title",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter post title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bodyController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          labelText: "Post Body",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter post body';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          child: const Text('Add Post'),
                          onPressed: () async {
                            //validating forms
                            if (_formKey.currentState!.validate()) {
                              setState(() => isLoading = true);
                              //saving post for a current user
                              await ApiService()
                                  .savePost(widget.user.id,
                                      titleController.text, bodyController.text)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text('Post added')));

                                //after success fetching posts for updated posts
                                widget.postsBloc.eventSink
                                    .add(PostsAction.Fetch);
                              });

                              setState(() => isLoading = false);
                            }
                          })
                    ],
                  ),
                )),
          ),
          isLoading
              ? Container(
                  color: Colors.grey.withOpacity(.5),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Container()
        ],
      ),
    );
  }
}
