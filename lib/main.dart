import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:plancation/pages/login_main/login_main.dart';
import 'package:url_strategy/url_strategy.dart';
import 'modules/color_schemes.g.dart';
import 'modules/firebase_options.dart';

void main() => initializeDateFormatting().then((value) async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF3A3D8F),
      systemNavigationBarColor: Color(0xFF3A3D8F)
    )
  );
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      setPathUrlStrategy();
      runApp(const MyApp());
    });

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Plancation',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Pretendard', colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, fontFamily: 'Pretendard', colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: const LoginMainPage(),
    );
  }
}
