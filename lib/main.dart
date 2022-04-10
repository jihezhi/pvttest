import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:quiver/async.dart';
import 'dart:math';



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
    return Scaffold(
      appBar: AppBar(
        title: Text('PVT'),
      ),
      body: StreamBuilder(
        stream: bloc._allNumbers.stream,
        builder: (context,AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: Text(snapshot.data.toString())
            );

          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return FloatingActionButton(
              onPressed: () => bloc.fetchnumber(),
            );
          }
        },
      ),
        floatingActionButton: FloatingActionButton(onPressed: () => bloc.dispose())
    );
  }
}

class NumberBloc {
  final _repository = Repository();
  final _numbersFetcher = PublishSubject<Stream<int>>();
  final _allNumbers = PublishSubject<int>();
  fetchnumber() async {
    Future.delayed(Duration(seconds: Random().nextInt(20)),
        () {
        var countDownTimer = CountdownTimer(
        const Duration(minutes: 20),
    const Duration(milliseconds: 100))
    ..forEach((element) {
    _allNumbers.add((element.elapsed.inMilliseconds/100).round());
    }); }
    );
  }

  dispose() {
    _allNumbers.close();
  }
}

class Repository {
  fetchnumber() => Stream.fromIterable(List<int>.generate(100000, (index) => index+1));
}
