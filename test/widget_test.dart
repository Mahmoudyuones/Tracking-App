import 'package:flutter_test/flutter_test.dart';

void main() {
  test('simple addition test', () {
    // arrange
    const int a = 2;
    const int b = 3;

    // act
    const int sum = a + b;

    // assert
    expect(sum, 5);
  });
}
