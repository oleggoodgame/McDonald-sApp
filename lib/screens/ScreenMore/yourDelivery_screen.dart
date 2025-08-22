import 'package:flutter/material.dart';
import 'package:mc_donalds/database/database.dart';
import 'package:mc_donalds/screens/ScreenMore/orderDetail_screen.dart';

class YourDeliveryScreen extends StatefulWidget {
  const YourDeliveryScreen({super.key});

  @override
  State<YourDeliveryScreen> createState() => _YourDeliveryScreenState();
}

class _YourDeliveryScreenState extends State<YourDeliveryScreen> {
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: db.getYourDelivers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No orders yet"));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final orderDoc = orders[index];

              return Dismissible(
                key: Key(orderDoc.id), 
                direction: DismissDirection.horizontal,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) async {
                  await db.deleteYourDelivery(orderDoc.id);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Order ${orderDoc.id} deleted")),
                  );
                },
                child: ListTile(
                  title: Text("Order ${index + 1}"),
                  subtitle: Text("ID: ${orderDoc.id}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderdetailScreen(orderDoc.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
