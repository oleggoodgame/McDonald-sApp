import 'package:flutter/material.dart';
import 'package:mc_donalds/models/more_model.dart';

class MoreCard extends StatelessWidget {
  final HasIconTitle item;
  final VoidCallback? onTap;

  const MoreCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Icon(item.icon, color: const Color.fromARGB(255, 110, 110, 110)),
                const SizedBox(width: 5),
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 110, 110, 110)),
                ),
                const Spacer(),
                const Icon(Icons.navigate_next_outlined,
                    color: Color.fromARGB(255, 110, 110, 110)),
              ],
            ),
            const SizedBox(height: 2),
            SizedBox(
              width: double.infinity,
              child: const Divider(height: 5, thickness: 1, color: Color.fromARGB(255, 110, 110, 110)),
            ),
          ],
        ),
      ),
    );
  }
}

