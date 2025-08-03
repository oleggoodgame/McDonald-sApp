import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/data/data.dart';
import 'package:mc_donalds/models/more_model.dart';
import 'package:mc_donalds/provider/profile_provider.dart';
import 'package:mc_donalds/screens/ScreenMore/editProfile_screen.dart';
import 'package:mc_donalds/screens/ScreenMore/profileVIew_screen.dart';
import 'package:mc_donalds/widgets/moreCard_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProfile = ref.read(profileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Hi ${userProfile.firstName}"),
              const Icon(Icons.account_circle),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: profileActions.length,
              itemBuilder: (context, index) {
                final action = profileActions[index];
                return InkWell(
                  onTap: () => _showOnTap(context, action.type),
                  child: MoreCard(item: action,),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showOnTap(BuildContext context, TypeProfileAction type) {
    if (type == TypeProfileAction.View) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileViewScreen()),
      );
    }
    else if(type==TypeProfileAction.Change){
      // тут нічого не буде поки що
    }
    else if(type==TypeProfileAction.Edit){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EditProfileScreen()),
      );
    }
    else if(type==TypeProfileAction.Share){
      // тут треба буде поцікавтись як поділитись
    }
    else if(type==TypeProfileAction.Delete){
      // і тут логічно видалити акаунт але теж поки що
    }
  }
}
