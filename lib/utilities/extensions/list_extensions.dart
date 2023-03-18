import 'dart:math';

extension ListExtensions on List {
  String get getRandomValue {
    Random random = Random();
    int index = random.nextInt(11);
    return this[index];
  }
}
