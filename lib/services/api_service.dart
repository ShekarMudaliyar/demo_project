import 'package:demo_project/configs/urls.dart';
import 'package:demo_project/models/postsmodel.dart';
import 'package:demo_project/models/usersmodel.dart';
import 'package:http/http.dart' as http;

//service for all apis
class ApiService {
  //instanciated object for urls class
  final Urls _urls = Urls();

  //method to get all users
  Future<List<Users>?> getUsers() {
    return http.get(Uri.parse(_urls.getUsers)).then((data) {
      try {
        if (data.statusCode == 200) {
          //if success it returns list of users
          return usersFromJson(data.body);
        }
      } catch (e) {
        return null;
      }
    });
  }

  //method to get all posts by a user
  Future<List<Post>?> getPosts(String? uid) {
    return http.get(Uri.parse(_urls.getUsers + "/$uid/posts")).then((data) {
      try {
        if (data.statusCode == 200) {
          //if success it returns list of posts
          return postFromJson(data.body);
        }
      } catch (e) {
        return null;
      }
    });
  }

  //method to save post for a user
  Future<String?> savePost(String? uid, String? title, String? body) {
    return http.post(
        Uri.parse(
          _urls.getUsers + "/$uid/posts",
        ),
        body: {"title": title, "body": body}).then((data) {
      try {
        if (data.statusCode == 200) {
          //it returns "Max number of elements reached for this resource!" so i'm assumming all response as success
          return data.body;
        }
      } catch (e) {
        return null;
      }
    });
  }
}
