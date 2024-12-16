import 'package:flutter/material.dart';
import 'package:multi_screen_app/planning_screen.dart';
import 'package:multi_screen_app/profile_screen.dart';
import 'package:multi_screen_app/ticket_screen.dart';
import 'home_screen.dart';

class BusRoutesScreen extends StatefulWidget {
  const BusRoutesScreen({super.key});

  @override
  _BusRoutesScreenState createState() => _BusRoutesScreenState();
}

class _BusRoutesScreenState extends State<BusRoutesScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final availableBuses = [
      {'busNumber': '61A - Inbound to Downtown', 'eta': '5 min'},
      {'busNumber': '71A - Inbound to Oakland', 'eta': '6 min'},
      {'busNumber': '71B - Inbound to Downtown', 'eta': '7 min'},
    ];

    final lateBuses = [
      {'busNumber': '61C - Inbound to Downtown', 'delay': '10 min'},
      {'busNumber': '71A - Inbound to Oakland', 'delay': '15 min'},
      {'busNumber': '75 - Inbound to Southside', 'delay': '20 min'},
    ];

    final nextBusesNearMe = [
      {'busNumber': '71D - Inbound to Oakland', 'eta': '2 min'},
      {'busNumber': '83 - Inbound to Downtown', 'eta': '3 min'},
      {'busNumber': '93 - Outbound to Lawrenceville', 'eta': '7 min'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Routes"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey[800],
                  child: const Center(
                    child: Text(
                      "Map Placeholder",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 60,
                  child: _buildBusOnMap('61A'),
                ),
                Positioned(
                  right: 30,
                  top: 90,
                  child: _buildBusOnMap('71A'),
                ),
                Positioned(
                  left: 80,
                  bottom: 30,
                  child: _buildBusOnMap('71B'),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Available Buses",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildBusList(availableBuses, context, "Available"),

                      const SizedBox(height: 20),

                      const Text(
                        "Late Buses",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildBusList(lateBuses, context, "Late"),

                      const SizedBox(height: 20),

                      const Text(
                        "Next Buses Near Me",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildBusList(nextBusesNearMe, context, "Nearby"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
      backgroundColor: Colors.grey[850],
    );
  }

  Widget _buildBusOnMap(String busNumber) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white70),
      ),
      child: Text(
        busNumber,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildBusList(List<Map<String, String>> buses, BuildContext context, String type) {
    return Column(
      children: buses.map((bus) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.grey[800],
                title: Text(
                  "Bus ${bus['busNumber']} Details",
                  style: const TextStyle(color: Colors.white70),
                ),
                content: Text(
                  type == "Available"
                      ? "ETA: ${bus['eta']}"
                      : type == "Late"
                      ? "Bus is delayed, new ETA is ${bus['delay']}"
                      : "ETA: ${bus['eta']}",
                  style: const TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Close",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Updated to light grey for contrast
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bus ${bus['busNumber']}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  type == "Available" || type == "Nearby"
                      ? bus['eta']!
                      : "${bus['delay']!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _onTabSelected(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanningScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TicketScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      default:
        break;
    }
  }
}
