import 'package:flutter/material.dart';

class OrderdDetailWidget extends StatelessWidget {
  const OrderdDetailWidget(this.title, this.price, this.count, {super.key});
  final String title;
  final double price;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(width: 5),
          Text(title),
          SizedBox(width: 15),
          Text("Price: ${price.toString()}"),
          SizedBox(width: 10,),
          Text("Count ${count.toString()}"),
          
        ],
      ),
    );
  }
}
