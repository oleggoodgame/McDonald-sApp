import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/vaucher_model.dart';
import 'package:mc_donalds/provider/profile_provider.dart';

class VaucherCard extends ConsumerWidget {
  final Vaucher vaucher;

  const VaucherCard({super.key, required this.vaucher});
  void _showApprove(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Apply voucher?"),
          content: const Text("Are you sure you want to apply this voucher?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                ref.read(profileProvider.notifier).activateVaucher(vaucher);
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Voucher "${vaucher.title}" activated'),
                  ),
                );
              },
              child: const Text("Apply"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String fifi = vaucher.type == TypeVaucher.discount ? "%" : "\$";
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
      elevation: 4,
      child: InkWell(
        onTap: () {
          _showApprove(context, ref);
        },
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    vaucher.photoPath,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  right: 0,
                  top: 50,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),

                    child: Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 3, // 270 градусів
                          child: Text(
                            fifi,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          vaucher.discount.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 7,
                  left: 12,
                  child: Image.asset(
                    "assets/images/vaucher.webp",
                    height: 40,
                    width: 40,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vaucher.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    vaucher.time,
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
