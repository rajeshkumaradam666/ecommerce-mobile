import 'package:ecommerce_mobile/Views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Controllers/auth_service.dart';
import 'Controllers/firestore_service.dart';
import 'Controllers/product_service.dart';
import 'Controllers/remote_config_service.dart';
import 'Views/login_page.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()),
        Provider(create: (_) => ProductService()),
        Provider(create: (_) => RemoteConfigService()),
        Provider(create: (_) => FirestoreService()),
      ],
      child: MaterialApp(
        title: 'E-Commerce Mobile',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

