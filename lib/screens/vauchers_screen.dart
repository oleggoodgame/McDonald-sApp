import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/data/data.dart';
import 'package:mc_donalds/widgets/vaucherCard_widget.dart';

class VauchersScreen extends ConsumerStatefulWidget {
  const VauchersScreen({super.key});

  @override
  ConsumerState<VauchersScreen> createState() => _VauchersScreenState();
}

class _VauchersScreenState extends ConsumerState<VauchersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: vaucherList.length,
        itemBuilder: (context, index) {
          return VaucherCard(vaucher: vaucherList[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    );
  }
}
