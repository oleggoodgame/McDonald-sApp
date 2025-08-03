import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/profile_model.dart';
import 'package:mc_donalds/provider/profile_provider.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  DateTime? _birthDate;
  String _email = '';
  Gender? _gender;

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.read(profileProvider);
    _firstName = userProfile.firstName;
    _lastName = userProfile.lastName;
    _birthDate = userProfile.birthDate;
    _email = userProfile.email;
    _gender = userProfile.gender;
    final formattedDate = DateFormat('yyyy-MM-dd').format(_birthDate!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Edit')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("* First Name"),
                      TextFormField(
                        initialValue: _firstName,
                        onSaved: (value) => userProfile.firstName = value ?? _firstName,
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 16),

                      const Text("*Email"),
                      TextFormField(
                        enabled: false,
                        initialValue: _email,
                        decoration: const InputDecoration(
                          helperText: "The email address cannot be changed.",
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text("Last Name"),
                      TextFormField(
                        initialValue: _lastName,
                        onSaved: (value) => userProfile.lastName = value ?? _lastName,
                      ),
                      const SizedBox(height: 16),

                      const Text("Gender"),
                      DropdownButtonFormField<Gender>(
                        value: _gender,
                        items: Gender.values.map((gender) {
                          final label = gender == Gender.male
                              ? 'Male'
                              : 'Female';
                          return DropdownMenuItem<Gender>(
                            value: gender,
                            child: Text(label),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            userProfile.gender = value;
                          }
                        },
                      ),

                      const SizedBox(height: 16),

                      const Text("Дата народження"),
                      TextFormField(
                        initialValue: formattedDate,
                        onTap: _pickDate,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'yyyy-MM-dd',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Скасувати"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: _saveChanges,
                child: const Text("Зберегти зміни"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) return;

      _formKey.currentState?.save();

      // ref
      //     .read(profileProvider.notifier)
      //     .updateProfile(
      //       firstName: _firstName,
      //       lastName: _lastName,
      //       gender: _gender,
      //       birthDate: _birthDate,
      //     );

      Navigator.pop(context);
    }

  Future<void> _pickDate() async { 
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2008, 6, 3),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _birthDate = picked;
       ref.read(profileProvider).birthDate = picked;
    }
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
