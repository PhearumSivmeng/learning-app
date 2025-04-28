import 'dart:io';

import 'package:demo/core/util/my_theme.dart';
import 'package:demo/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserModel user;
  final ImagePicker _picker = ImagePicker();
  XFile? _newCoverImage;
  XFile? _newProfileImage;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  Future<void> _pickImage(bool isCoverPhoto) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          if (isCoverPhoto) {
            _newCoverImage = image;
          } else {
            _newProfileImage = image;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Controllers initialization remains the same
    final firstNameController = TextEditingController(text: user.firstName);
    final lastNameController = TextEditingController(text: user.lastName);
    final genderController = TextEditingController(text: user.gender);
    final phoneController = TextEditingController(text: user.phone);
    final emailController = TextEditingController(text: user.email);
    final bioController = TextEditingController(text: user.bio);

    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 195, 50, 50),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Profile Information',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10), // Add some space between text and logo
            Container(
              margin: EdgeInsets.only(right: MyTheme.addBarSpace),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/e-learning.png'),
                ),
              ),
            ),
          ],
        ),
        actions: [SizedBox(width: 40)], // This balances the leading arrow
      ),
      backgroundColor: MyTheme.bodyBackground,
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Cover Photo Section
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          image: DecorationImage(
                            image: _newCoverImage != null
                                ? FileImage(File(_newCoverImage!.path))
                                : NetworkImage(user.profileCover.replaceAll(
                                    "localhost", "10.0.2.2")) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: CircleAvatar(
                          backgroundColor:
                              Colors.blue.shade600.withOpacity(0.8),
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () => _pickImage(true),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Picture (positioned over the cover)
                        Transform.translate(
                          offset: const Offset(0, -80),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 52,
                                  backgroundImage: _newProfileImage != null
                                      ? FileImage(File(_newProfileImage!.path))
                                      : NetworkImage(
                                          user.profile.replaceAll(
                                              "localhost", "10.0.2.2"),
                                        ) as ImageProvider,
                                ),
                              ),
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue.shade600,
                                  radius: 18,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: () => _pickImage(false),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16), // Reduced from 24

                        // Rest of your form fields remain the same
                        buildTextField(
                          controller: firstNameController,
                          label: 'First Name',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 16),

                        buildTextField(
                          controller: lastNameController,
                          label: 'Last Name',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),

                        buildTextField(
                          controller: genderController,
                          label: 'Gender',
                          icon: Icons.wc,
                        ),
                        const SizedBox(height: 16),

                        buildTextField(
                          controller: phoneController,
                          label: 'Phone Number',
                          icon: Icons.phone,
                          inputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),

                        buildTextField(
                          controller: emailController,
                          label: 'Email',
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          isReadOnly: true,
                        ),
                        const SizedBox(height: 16),

                        buildTextField(
                          controller: bioController,
                          label: 'Bio',
                          icon: Icons.info,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 30),

                        // Save Changes Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Save both profile and cover images
                              if (_newProfileImage != null) {
                                print(
                                    'New profile image: ${_newProfileImage!.path}');
                              }
                              if (_newCoverImage != null) {
                                print(
                                    'New cover image: ${_newCoverImage!.path}');
                              }
                              print('First Name: ${firstNameController.text}');
                              print('Last Name: ${lastNameController.text}');
                              print('Gender: ${genderController.text}');
                              print('Phone: ${phoneController.text}');
                              print('Email: ${emailController.text}');
                              print('Bio: ${bioController.text}');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable TextField widget remains the same
  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    bool isReadOnly = false,
  }) {
    return TextFormField(
      readOnly: isReadOnly,
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
