import 'package:flutter/material.dart';
import 'package:multi_screen_app/bus_routes_screen.dart';
import 'package:multi_screen_app/profile_screen.dart';
import 'package:multi_screen_app/ticket_screen.dart';

import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: PlanningScreen(),
  ));
}

class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  TextEditingController _departureController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  List<Map<String, String>> _savedTrips = [];

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan Your Trip"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField("Departure Location", _departureController),
            SizedBox(height: 10),
            _buildTextField("Destination", _destinationController),
            SizedBox(height: 10),
            _buildDatePicker(),
            SizedBox(height: 10),
            _buildTimePicker(),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                setState(() {
                  _savedTrips.add({
                    'departure': _departureController.text,
                    'destination': _destinationController.text,
                    'date': _dateController.text,
                    'time': _timeController.text,
                  });
                });
              },
              child: Text("Plan Trip", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _savedTrips.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text("${_savedTrips[index]['departure']} to ${_savedTrips[index]['destination']}"),
                      subtitle: Text("${_savedTrips[index]['date']} at ${_savedTrips[index]['time']}"),
                    ),
                  );
                },
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
    );
  }

  Widget _buildDatePicker() {
    return TextField(
      controller: _dateController,
      decoration: InputDecoration(
        labelText: "Select Date",
        hintText: "Select Date",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (selectedDate != null) {
          setState(() {
            _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
          });
        }
      },
    );
  }

  Widget _buildTimePicker() {
    return TextField(
      controller: _timeController,
      decoration: InputDecoration(
        labelText: "Select Time",
        hintText: "Select Time",
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (selectedTime != null) {
          setState(() {
            _timeController.text = selectedTime.format(context);
          });
        }
      },
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
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BusRoutesScreen()),
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
