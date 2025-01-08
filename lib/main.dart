import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assesment/provider/movie_player_provider.dart';
import 'package:tentwenty_assesment/presentaion/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => MoviePlayerProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          textTheme:
              const TextTheme(titleSmall: TextStyle(fontFamily: "Roboto")),
          useMaterial3: true,
        ),
        home: const BottomNavBar(),
      ),
    );
  }
}
