import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/services/auth.dart';

import 'app/landing_page.dart';

//
// void addLessThanFive(StreamController controller, int value) {
//   if (value < 5) {
//     controller.sink.add(value);
//   } else {
//     controller.sink.addError(StateError('$value is not less than 5'));
//   }
// }

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());

  // final controller = StreamController();
  // controller.sink.add(1);
  // controller.sink.add(2);
  //
  // controller.stream.listen((value) {
  //   print(value);
  // });
  //
  // addLessThanFive(controller, 1);
  // addLessThanFive(controller, 2);
  // addLessThanFive(controller, 5);
  // addLessThanFive(controller, 6);
  // addLessThanFive(controller, 7);
  //
  // controller.close();
  //
  // controller.stream.listen((value) => print(value), onError: (err) {
  //   print(err);
  // }, onDone: () {
  //   print('done');
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
