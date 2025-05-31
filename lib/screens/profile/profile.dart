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
  bool _allowAIDataUsage = false;
  final TextEditingController _requestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = widget.user;
    // Initialize AI usage preference (you might load this from user's settings)
    _allowAIDataUsage = false;
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

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account Request'),
        content: const Text(
          'Are you sure you want to request account deletion? This action will be reviewed by our team and you\'ll be notified before any permanent deletion occurs.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // TODO: Implement account deletion request logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion request submitted'),
                ),
              );
            },
            child: const Text('Request Deletion'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Last Updated: January 1, 2023\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                '1. Information We Collect\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'We collect personal information you provide when you create an account, including your name, email, and profile data.\n\n',
              ),
              const Text(
                '2. How We Use Your Data\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'Your data is used to provide and improve our services. With your consent, we may use anonymized data for AI training purposes.\n\n',
              ),
              const Text(
                '3. Data Security\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'We implement industry-standard security measures to protect your personal information.\n',
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _allowAIDataUsage,
                    onChanged: (value) {
                      setState(() {
                        _allowAIDataUsage = value ?? false;
                      });
                      Navigator.pop(context);
                      // TODO: Save this preference to user settings
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Allow anonymized data usage for AI improvement',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportDataToPDF() async {
    // TODO: Implement actual PDF export functionality
    // This would typically involve:
    // 1. Gathering all user data
    // 2. Generating a PDF document
    // 3. Saving/sharing the PDF

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preparing your data export...'),
        duration: Duration(seconds: 2),
      ),
    );

    // Simulate PDF generation delay
    await Future.delayed(const Duration(seconds: 2));

    // Show completion message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data exported successfully! Check your downloads.'),
        ),
      );
    }
  }

  void _submitRequest() {
    if (_requestController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your request')),
      );
      return;
    }

    // TODO: Implement request submission logic
    print('User request: ${_requestController.text}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request submitted successfully!')),
    );

    _requestController.clear();
  }

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '[ Profile Information ]',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [SizedBox(width: 40)],
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
                  // Cover Photo Section (unchanged)
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
                                : NetworkImage(user.profileCover!.replaceAll(
                                        "192.168.70.70:8080", "10.0.2.2:8000"))
                                    as ImageProvider,
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
                        horizontal: 24.0, vertical: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Picture (unchanged)
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
                                              "192.168.70.70:8080",
                                              "10.0.2.2:8000"),
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

                        // Original form fields (unchanged)
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
                        const SizedBox(height: 20),

                        // New: Additional buttons section
                        const Divider(thickness: 1),
                        const SizedBox(height: 10),
                        const Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Privacy Policy Button
                        _buildSettingButton(
                          icon: Icons.privacy_tip,
                          text: 'View Privacy Policy',
                          onTap: _showPrivacyPolicy,
                        ),

                        // Export Data Button
                        _buildSettingButton(
                          icon: Icons.import_export,
                          text: 'Export My Data to PDF',
                          onTap: _exportDataToPDF,
                        ),

                        // Delete Account Button
                        _buildSettingButton(
                          icon: Icons.delete_forever,
                          text: 'Request Account Deletion',
                          color: Colors.red,
                          onTap: _showDeleteAccountDialog,
                        ),

                        // AI Data Usage Toggle
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.auto_awesome,
                                  color: Colors.blue),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Text(
                                  'Allow AI to use my data (anonymized)',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Switch(
                                value: _allowAIDataUsage,
                                onChanged: (value) {
                                  setState(() {
                                    _allowAIDataUsage = value;
                                  });
                                  // TODO: Save this preference
                                },
                                activeColor: Colors.blue,
                              ),
                            ],
                          ),
                        ),

                        // Request/Feedback Section
                        const SizedBox(height: 20),
                        const Text(
                          'Have a special request?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _requestController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Type your request or feedback here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitRequest,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Submit Request',
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

  Widget _buildSettingButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color color = Colors.blue,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          alignment: Alignment.centerLeft,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable TextField widget (unchanged)
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
