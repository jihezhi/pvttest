import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rxdart/rxdart.dart';
import 'dart:async';


void main() {
  runApp(const MyApp());
}
final bloc = NumberBloc();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PVT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _MyHomePageState(),
    );
  }
}


class _MyHomePageState extends StatelessWidget {
  const _MyHomePageState({Key? key}):super(key:key);
  @override
  Widget build(BuildContext context) {
    bloc.fetchnumber();
    return Scaffold(
      appBar: AppBar(
        title: Text('PVT'),
      ),
      body: StreamBuilder(
        stream: Stream.fromIterable(List<int>.generate(100000, (index) => index+1)).interval(Duration(seconds: 1)),
        builder: (context,AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Center(child:Text(snapshot.data.toString()));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Text('error');
          }
        },
      ),
    );
  }
}

class NumberBloc {
  final _repository = Repository();
  final _numbersFetcher = PublishSubject<int>();
  final _allNumbers = BehaviorSubject<int>();
  fetchnumber() async {
    _numbersFetcher
      ..addStream(_repository.fetchnumber())..forEach((element) {_allNumbers.add(element);});
  }

  dispose() {
    _numbersFetcher.close();
  }
}

class Repository {
  fetchnumber() => Stream.fromIterable(List<int>.generate(100000, (index) => index+1));
}
