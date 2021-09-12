class Validators {
  static String? titleValidator(String? str) {
    return str!.isEmpty ? "Please enter Post title" : null;
  }

  static String? bodyValidator(String? str) {
    return str!.isEmpty ? "Please enter Post body" : null;
  }
}
