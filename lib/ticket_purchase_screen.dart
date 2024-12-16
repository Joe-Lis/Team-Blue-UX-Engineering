import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_screen_app/successful_purchase_screen.dart';
import 'globals.dart';

class TicketPurchaseScreen extends StatelessWidget {
  const TicketPurchaseScreen({super.key});

  final List<Map<String, dynamic>> availableFares = const [
    {'name': '3-Hour Pass', 'price': 2.75},
    {'name': 'Day Pass', 'price': 7.00},
    {'name': '7 Day Pass', 'price': 25.00},
    {'name': '31 Day Pass', 'price': 97.50},
    {'name': 'Annual Pass', 'price': 1072.50},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Tickets'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFF8F9FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 40),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Available fares',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: availableFares.length,
                itemBuilder: (context, index) {
                  final fare = availableFares[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Purchase ${fare['name']}?"),
                          content: Text(
                            "Do you want to purchase this pass for \$${fare['price'].toStringAsFixed(2)}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                purchasedTickets.add({
                                  'name': fare['name'],
                                  'price': fare['price'],
                                });
                                Navigator.of(context).pop(); // Close dialog
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SuccessfulPurchaseScreen(
                                      ticketName: fare['name'],
                                      ticketPrice: fare['price'],
                                    ),
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

                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blueAccent,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              fare['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade800,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '\$${fare['price'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
