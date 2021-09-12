import 'dart:async';

import 'package:demo_project/models/usersmodel.dart';
import 'package:demo_project/services/api_service.dart';

//defined enum for event actions to fetch,add,delete
enum UsersAction {
  Fetch,
}

class UsersBloc {
  //stream to save all users data
  final streamController = StreamController<List<Users>>();
  StreamSink<List<Users>> get userSink => streamController.sink;
  Stream<List<Users>> get userStream => streamController.stream;

  //events controller to communicate between ui and stream
  final eventController = StreamController<UsersAction>();
  StreamSink<UsersAction> get eventSink => eventController.sink;
  Stream<UsersAction> get eventStream => eventController.stream;

  UsersBloc() {
    //listening to events for users action
    eventStream.listen((event) async {
      if (event == UsersAction.Fetch) {
        try {
          //calling api to fetch users
          var users = await ApiService().getUsers();
          if (users != null) {
            //if the data is not null saving posts in post stream
            userSink.add(users);
          } else {
            //if some error thowing error in stream
            userSink.addError('Something went wrong');
          }
        } catch (e) {
          //if some error thowing error in stream
          userSink.addError('Something went wrong');
        }
      }
    });
  }
  void dispose() {
    //disposing all stream controllers
    streamController.close();
    eventController.close();
  }
}
