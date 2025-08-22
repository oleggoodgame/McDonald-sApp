import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mc_donalds/screens/start/authenticate.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( ProviderScope( 
      child: App(), 
    ));
}


class App extends ConsumerWidget {
  const App({super.key});

 
  @override
  Widget build(BuildContext contextW, WidgetRef ref) {
   
    return MaterialApp(
      home: const Authenticate(),
    );
  }
}
