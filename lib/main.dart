import 'package:flutter/material.dart';
import 'package:multi_screen_app/ticket_purchase_screen.dart';
import 'ticket_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HopOn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/tickets': (context) => const TicketScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/purchase': (context) => const TicketPurchaseScreen(),
      },
    );
  }
}
