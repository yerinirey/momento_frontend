import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:momento/providers/image_store.dart';
import 'package:momento/providers/moment_store.dart';
import 'package:provider/provider.dart';
import 'screens/root_screen.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 초기화 작업 수행 코드, db 불러오기 등
  await Future.delayed(const Duration(seconds: 2));

  // 초기화 작업이 끝났을 때 Splash화면을 제거함.
  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageStore()),
        ChangeNotifierProvider(create: (_) => MomentStore()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momento App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const RootScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
