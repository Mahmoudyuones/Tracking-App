import 'package:flutter_test/flutter_test.dart';

void main() {
  test('simple addition test', () {
    // arrange
    int a = 2;
    int b = 3;

    // act
    int sum = a + b;

    // assert
    expect(sum, 5);
  });
}
