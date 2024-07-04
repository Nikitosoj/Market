import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_notifier.dart';
import 'features/root/app_routing.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://bejaniqevmgoiiwvefvj.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJlamFuaXFldm1nb2lpd3ZlZnZqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcyMDA3ODIsImV4cCI6MjAyMjc3Njc4Mn0.rLxF6icLiHyb6CCeCbCm07N0GO7baccZwTpjF6l05Q0');
  runApp(ChangeNotifierProvider(
      create: (_) => AuthNotifier(), child: const MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        });
  }
}
