import 'package:flutter/material.dart';

class SuccessfulPurchaseScreen extends StatelessWidget {
  final String ticketName;
  final double ticketPrice;

  const SuccessfulPurchaseScreen({
    super.key,
    required this.ticketName,
    required this.ticketPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Purchase Successful"),
      backgroundColor: Colors.blueAccent,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You successfully purchased a $ticketName for \$${ticketPrice.toStringAsFixed(2)}!",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/tickets',
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                "Go to Tickets",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text(
                "Go to Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
