import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/screens/load_screen.dart';

void main() {
  runApp( ProviderScope( 
      child: App(), 
    ));
}


class App extends ConsumerWidget {
  const App({super.key});

 
  @override
  Widget build(BuildContext contextW, WidgetRef ref) {
   
    return MaterialApp(
      home: const McLoadScreen(),
    );
  }
}
