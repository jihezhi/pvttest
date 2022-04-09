import 'dart:math';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

void main() {
  PublishSubject<int>()..addStream(Stream.fromIterable(List<int>.generate(100, (index) => index+1)).debounceTime(Duration(seconds: 1)))..listen(print);
}