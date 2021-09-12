import 'dart:async';
import 'package:demo_project/models/postsmodel.dart';
import 'package:demo_project/models/usersmodel.dart';
import 'package:demo_project/services/api_service.dart';

//defined enum for event actions to fetch,add,delete
enum PostsAction {
  Fetch,
}

class PostsBloc {
  //Users object for saving current user
  late Users _currentUser = Users();

  //stream to save all posts data
  final streamController = StreamController<List<Post>>.broadcast();
  StreamSink<List<Post>> get postSink => streamController.sink;
  Stream<List<Post>> get postStream => streamController.stream;

  //events controller to communicate between ui and stream
  final eventController = StreamController<PostsAction>();
  StreamSink<PostsAction> get eventSink => eventController.sink;
  Stream<PostsAction> get eventStream => eventController.stream;

  //controller to set current user
  final setCurretUserEventController = StreamController<Users>();
  StreamSink<Users> get setCurretUserEventSink =>
      setCurretUserEventController.sink;
  Stream<Users> get setCurretUserEventStream =>
      setCurretUserEventController.stream;

  PostsBloc() {
    //listening to events for posts action
    eventStream.listen((event) async {
      if (event == PostsAction.Fetch) {
        try {
          //calling api to fetch posts
          var posts = await ApiService().getPosts(_currentUser.id);
          if (posts != null) {
            //if the data is not null saving posts in post stream
            postSink.add(posts);
          } else {
            //if some error thowing error in stream
            postSink.addError('Something went wrong');
          }
        } catch (e) {
          //if some error thowing error in stream
          postSink.addError('Something went wrong');
        }
      }
    });

    //listening to save current user
    setCurretUserEventStream.listen((user) async {
      try {
        //saving current user
        _currentUser = user;
      } catch (e) {
        //if some error thowing error in stream
        setCurretUserEventSink.addError('Something went wrong');
      }
    });
  }

  void dispose() {
    //disposing all stream controllers
    streamController.close();
    eventController.close();
    setCurretUserEventController.close();
  }
}
