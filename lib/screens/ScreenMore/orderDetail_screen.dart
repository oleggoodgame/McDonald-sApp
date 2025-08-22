import 'package:flutter/material.dart';
import 'package:mc_donalds/database/database.dart';
import 'package:mc_donalds/widgets/orderDetail_widget.dart';

class OrderdetailScreen extends StatefulWidget {
  const OrderdetailScreen(this.deliverId, {super.key});
  final String deliverId;
  @override
  State<OrderdetailScreen> createState() => _OrderdetailScreenState();
}

class _OrderdetailScreenState extends State<OrderdetailScreen> {
  final db = DatabaseService();
  String total = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(total)),
      body: FutureBuilder(
        future: db.getYourDeliverOne(widget.deliverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) return const Center(child: Text("No data"));

          final doc = snapshot.data!;
          final data = doc.data() as Map<String, dynamic>;
          final total = data['totalPrice'] ?? "0";
          final List items = data['items'] as List;

          return Column(
            children: [
              Text("Total: $total", style: const TextStyle(fontSize: 18)),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index] as Map<String, dynamic>;
                    return OrderdDetailWidget(
                      item['title'] as String,
                      item['price'],
                      item['count'],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
