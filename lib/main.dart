import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_bd_contacts/contacts_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/contacts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Tutorial',
      home: FutureBuilder(
        future: Hive.openBox('contacts'),
        builder: (context, snapshot) {
          print("ok lets go");
          if (snapshot.connectionState == ConnectionState.done) {
            print('все ок');
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return ContactPage();
          }
          // Although opening a Box takes a very short time,
          // we still need to return something before the Future completes.
          else {
            print('плохо');
            return Scaffold();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('contacts').close();
    super.dispose();
  }
}
