import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'home_screen.dart';
import 'bus_routes_screen.dart';
import 'planning_screen.dart';
import 'ticket_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi [User]! ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                _buildOption('My account', () {}),
                _buildOption('Ticket History', () {}),
                _buildOption('Wallet', () {}),
                _buildOption('Settings', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                }),
                _buildOption('Help', () {}),
                _buildOption('Logout', () {}, textColor: Colors.red),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BusRoutesScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PlanningScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TicketScreen()),
              );
              break;
            case 4:
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Purchase',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String title, VoidCallback onTap, {Color textColor = Colors.black}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
