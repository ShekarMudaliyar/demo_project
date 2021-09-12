import 'package:demo_project/services/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('title validators test', () {
    var result = Validators.titleValidator('');
    expect(result, 'Please enter Post title');

    var resultBeingNull = Validators.titleValidator('something');
    expect(resultBeingNull, null);
  });

  test('body validators test', () {
    var result = Validators.bodyValidator('');
    expect(result, 'Please enter Post body');

    var resultBeingNull = Validators.bodyValidator('something');
    expect(resultBeingNull, null);
  });
}
