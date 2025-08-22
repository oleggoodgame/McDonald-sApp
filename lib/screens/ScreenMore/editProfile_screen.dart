import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/database/database.dart';
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
  final db = DatabaseService();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _birthDateController;
  Gender? _gender;
  DateTime? _birthDate;

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _birthDateController = TextEditingController();

    db.getProfile().then((profile) {
      if (profile != null) {
        ref
            .read(profileProvider.notifier)
            .updateProfile(
              firstName: profile.firstName,
              lastName: profile.lastName,
              email: profile.email,
              gender: profile.gender,
              birthDate: profile.birthDate,
            );

        setState(() {
          _firstNameController.text = profile.firstName;
          _lastNameController.text = profile.lastName;
          _emailController.text = profile.email;
          _birthDate = profile.birthDate;
          _birthDateController.text = profile.birthDate != null
              ? DateFormat('yyyy-MM-dd').format(profile.birthDate!)
              : '';
          _gender = profile.gender;
        });
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Edit')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("* First Name"),
                TextFormField(
                  controller: _firstNameController,
                  validator: _requiredValidator,
                ),
                const SizedBox(height: 16),

                const Text("* Email"),
                TextFormField(
                  controller: _emailController,
                  enabled: false,
                  decoration: const InputDecoration(
                    helperText: "The email address cannot be changed.",
                  ),
                ),
                const SizedBox(height: 16),

                const Text("Last Name"),
                TextFormField(controller: _lastNameController),
                const SizedBox(height: 16),

                const Text("Gender"),
                DropdownButtonFormField<Gender>(
                  value: _gender,
                  items: [
                    ...Gender.values.map((gender) {
                      final label = gender == Gender.nothing
                          ? 'Nothing'
                          : (gender == Gender.male ? 'Male' : 'Female');
                      return DropdownMenuItem<Gender>(
                        value: gender,
                        child: Text(label),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    ref
                        .read(profileProvider.notifier)
                        .updateProfile(gender: value ?? Gender.male);
                    setState(() {
                      _gender = value;
                    });
                  },
                ),

                const SizedBox(height: 16),

                const Text("Дата народження"),
                TextFormField(
                  controller: _birthDateController,
                  readOnly: true,
                  onTap: _pickDate,
                  decoration: const InputDecoration(hintText: 'yyyy-MM-dd'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
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
    if (!_formKey.currentState!.validate()) return;

    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;

    ref
        .read(profileProvider.notifier)
        .updateProfile(firstName: firstName, lastName: lastName);
    ref.read(profileProvider).firstName = firstName;
    if (_birthDate != null) {
      db.updateProfile(
        firstName,
        lastName,
        _gender ?? Gender.male,
        _birthDate!,
      );
    } else {
      db.updateProfile(
        firstName,
        lastName,
        _gender ?? Gender.male,
        null
      );
    }

    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });

      ref.read(profileProvider.notifier).updateProfile(birthDate: picked);
    }
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }
}
