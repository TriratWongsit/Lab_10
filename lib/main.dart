import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/login_screen.dart'; // เรียกหน้า Login ที่เราสร้างใหม่

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FakeStore App',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        home: const LoginScreen(), // เปลี่ยนจาก UserListScreen เป็น LoginScreen
      ),
    );
  }
}