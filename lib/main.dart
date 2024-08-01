import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/features/cart/bloc/cart_bloc.dart';
import 'package:style_hub/features/catalog/bloc/catalog_bloc.dart';
import 'package:style_hub/features/payment/bloc/payment_bloc.dart';
import 'package:style_hub/features/profile/bloc/profile_bloc.dart';
import 'auth_notifier.dart';
import 'core/models/database_model.dart';
import 'features/root/app_routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (_) => AuthNotifier(), child: const MyApp()));
}

FirebaseModel firebase = FirebaseModel();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CatalogBloc()),
              BlocProvider(create: (context) => CartBloc()),
              BlocProvider(create: (context) => ProfileBloc()),
              BlocProvider(create: (context) => PaymentBloc()),
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
            ),
          );
        });
  }
}
