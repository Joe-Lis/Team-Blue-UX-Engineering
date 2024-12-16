import 'package:flutter/material.dart';
import 'package:multi_screen_app/home_screen.dart';
import 'globals.dart';
import 'bus_routes_screen.dart';
import 'planning_screen.dart';
import 'profile_screen.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int _currentIndex = 3;

  void _onTabSelected(int index) {
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
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Screen"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Purchased Tickets",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 10),
            Container(
              height: 570,
              width: 350,
              child: ListView.builder(
                itemCount: purchasedTickets.length,
                itemBuilder: (context, index) {
                  final ticket = purchasedTickets[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const Icon(Icons.directions_bus, color: Colors.grey),
                      title: Text(ticket['name']),
                      subtitle: Text('\$${ticket['price'].toStringAsFixed(2)}'),
                      trailing: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Activate Pass"),
                              content: Text(
                                  "Do you want to activate the ${ticket['name']}?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      purchasedTickets.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "No",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          "Activate",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/purchase');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: const Text(
                      "Purchase Tickets",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _onTabSelected(index);
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
}
