import 'dart:math';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

void main() {
  final stream = Stream.empty();
  stream.listen(print);
  stream.mergeWith([Stream.fromIterable(List<int>.generate(100000, (index) => index+1)).interval(Duration(seconds: 1))]);
  stream.listen(print);
  Future.delayed(Duration(seconds: 5),() => stream.listen(print).cancel());

}