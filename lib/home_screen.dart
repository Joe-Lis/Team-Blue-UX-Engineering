import 'package:flutter/material.dart';
import 'package:multi_screen_app/bus_routes_screen.dart';
import 'package:multi_screen_app/planning_screen.dart';
import 'package:multi_screen_app/profile_screen.dart';
import 'package:multi_screen_app/ticket_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HopOn",
          style: TextStyle(fontFamily: 'RobotoCondensed'),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: _currentIndex == 0
          ? _buildHomeScreen()
          : Center(
        child: Text(
          "Current Index: $_currentIndex",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

  Widget _buildHomeScreen() {
    final List<Map<String, dynamic>> nearbyBuses = [
      {"name": "61A - Inbound to Downtown", "status": "medium", "arrivalMinutes": 5},
      {"name": "61A - Outbound to North Braddock", "status": "low", "arrivalMinutes": 3},
      {"name": "61B - Inbound to Downtown", "status": "full", "arrivalMinutes": 8},
      {"name": "61B - Outbound to Braddock-Swissvale", "status": "", "arrivalMinutes": 2},
      {"name": "61C - Inbound to Downtown", "status": "low", "arrivalMinutes": 15},
      {"name": "61C - Outbound to McKeesport", "status": "medium", "arrivalMinutes": 7},
      {"name": "61D - Inbound to Oakland", "status": "", "arrivalMinutes": 4},
      {"name": "61D - Outbound to Murray", "status": "full", "arrivalMinutes": 10},
      {"name": "71A - Inbound to Oakland", "status": "medium", "arrivalMinutes": 15},
      {"name": "71A - Outbound to Highland Park", "status": "low", "arrivalMinutes": 9},
      {"name": "71B - Inbound to Downtown", "status": "full", "arrivalMinutes": 2},
      {"name": "71B - Outbound to Highland Park", "status": "", "arrivalMinutes": 5},
      {"name": "71C - Inbound to Oakland", "status": "low", "arrivalMinutes": 3},
      {"name": "71C - Outbound to Wilkinsburg Station", "status": "medium", "arrivalMinutes": 8},
      {"name": "71D - Inbound to Oakland", "status": "", "arrivalMinutes": 1},
      {"name": "71D - Outbound to Wilkinsburg Station", "status": "full", "arrivalMinutes": 1}
    ];

    Color getStatusColor(String status) {
      switch (status) {
        case "full":
          return Colors.red; // Full = Red
        case "medium":
          return Colors.amber.shade400; // Medium = Yellow
        case "low":
          return Colors.green; // Low = Green
        default:
          return Colors.grey; // Default color
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onChanged: (value) {
                print("Search query: $value");
              },
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Nearby Buses",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: nearbyBuses.length,
            itemBuilder: (context, index) {
              final bus = nearbyBuses[index];
              final color = getStatusColor(bus["status"]);

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Icon(Icons.directions_bus, color: color),
                  title: Text(bus["name"],
                      style: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  subtitle: Text(
                      bus["status"] == "full"
                          ? "Bus is full"
                          : bus["status"] == "medium"
                          ? "Moderately full"
                          : bus["status"] == "low"
                          ? "Seats available"
                          : "No capacity information",
                      style: const TextStyle(
                        fontFamily: 'RobotoCondensed',
                      )
                  ),
                  trailing: bus.containsKey("arrivalMinutes")
                      ? Text(
                    "${bus["arrivalMinutes"]} min",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : const Text("No Data",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  void _onTabSelected(int index) {
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusRoutesScreen()),
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