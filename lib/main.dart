import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'modules/firebase_options.dart';
import "modules/image_picker.dart";
import 'modules/firebase_login.dart';
import 'modules/kakao_login.dart';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    KakaoSdk.init(nativeAppKey: '832accb12e772f529ef4b1a1e529e8c9', javaScriptAppKey: 'fb8af3ca919e510985f8fbefa2599e8e');
    Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => print(value));
    void getData() async {
      String? userID = await FlutterSecureStorage().read(key: "userID");
      Logger().d("FlutterSecureStorage: $userID");
    }
    getData();


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final formKey = new GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _phoneNumber = "";
  String _code = "";
  bool isSent = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void handleLogin() {
    // print(_email);
    // print(_password);
    // AuthManage().signIn(_email, _password);
    AuthManage().signInWithGoogle();

    // ImageSelector().getImage(ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // child:
        //   Image.asset("assets/images/asdf.png"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Email"),
                    onChanged: (value) => _email = value,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) => _password = value,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  FilledButton(
                      onPressed: handleLogin,
                      child: const Text(
                        "Login"
                      )
                  ),
                  FilledButton(
                      onPressed: Kakao().signInWithKakao,
                      child: const Text(
                        "Kakao Login"
                      )
                  )
                ],
              ),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
