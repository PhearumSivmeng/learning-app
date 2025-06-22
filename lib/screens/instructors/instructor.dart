import 'package:demo/core/util/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class InstructorAgreementPage extends StatefulWidget {
  const InstructorAgreementPage({super.key});

  @override
  State<InstructorAgreementPage> createState() =>
      _InstructorAgreementPageState();
}

class _InstructorAgreementPageState extends State<InstructorAgreementPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  bool _isAgreed = false;
  PlatformFile? _cvFile;
  String? _selectedUniversity;
  String? _selectedEducation;

  // Sample data for dropdowns
  final List<String> _universities = [
    'Harvard University',
    'Stanford University',
    'MIT',
    'Oxford University',
    'Other'
  ];

  final List<String> _educationLevels = [
    'PhD',
    'Master’s Degree',
    'Bachelor’s Degree',
    'Diploma',
    'Other'
  ];

  Future<void> _pickCVFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null) {
        setState(() {
          _cvFile = result.files.first;
        });
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick file: ${e.message}')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _isAgreed) {
      // Handle submission (e.g., API call with all fields + _cvFile)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submission successful!')),
      );
      // Debug print all data
      debugPrint('''
        Name: ${_nameController.text}
        Email: ${_emailController.text}
        Phone: ${_phoneController.text}
        University: $_selectedUniversity
        Education: $_selectedEducation
        DOB: ${_dobController.text}
        Description: ${_descriptionController.text}
        CV File: ${_cvFile?.name}
      ''');
    } else if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructor Agreement'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: MyTheme.bodyBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Terms and Conditions (Collapsible)
                ExpansionTile(
                  title: const Text('Terms and Conditions',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '''Instructors play a vital role in fostering a positive learning environment and ensuring the academic growth of their students. These terms and conditions outline the responsibilities and expectations for instructors to maintain professionalism and uphold the institution's values.  \n\nInstructors are expected to deliver high-quality teaching, ensuring that all materials and lessons are well-prepared, accurate, and aligned with the curriculum. The use of up-to-date and original content is essential to provide students with a meaningful learning experience. Maintaining respect and professionalism in all interactions with students, colleagues, and institutional staff is crucial, fostering a collaborative and supportive atmosphere.  \n\nPunctuality and commitment to scheduled classes and deadlines are fundamental responsibilities. Instructors must manage their time effectively and communicate promptly in case of any unforeseen changes. Providing constructive and transparent feedback is a key part of the instructor's role, guiding students in their academic journey while encouraging growth and improvement.  \n\nConfidentiality is an essential aspect of the instructor's duties. Safeguarding students' personal information, academic records, and other sensitive data is mandatory. Instructors are also required to comply with all institutional policies and guidelines, ensuring their teaching practices align with established standards.  \n\nContinuous professional development is encouraged, with instructors expected to stay informed about new teaching methods, industry developments, and advancements in technology to enhance the educational experience. Institutional resources provided for teaching purposes should be used responsibly and with care to maintain their availability for all.  \n\nBy adhering to these terms and conditions, instructors commit to upholding the highest standards of education and professionalism, creating an environment where students can thrive and achieve their goals.''',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12)), // More rounded
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12)), // More rounded
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone Field
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12)), // More rounded
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // University Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedUniversity,
                  decoration: const InputDecoration(
                    labelText: 'University',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12)), // More rounded
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  items: _universities
                      .map((uni) => DropdownMenuItem(
                            value: uni,
                            child: Text(uni),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedUniversity = value),
                  validator: (value) =>
                      value == null ? 'Select a university' : null,
                ),
                const SizedBox(height: 16),

                // Education Level Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedEducation,
                  decoration: const InputDecoration(
                    labelText: 'Education-Level',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12)), // More rounded
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  items: _educationLevels
                      .map((edu) => DropdownMenuItem(
                            value: edu,
                            child: Text(edu),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedEducation = value),
                  validator: (value) =>
                      value == null ? 'Select education level' : null,
                ),
                const SizedBox(height: 16),

                // Date of Birth
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12)), // More rounded
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Select DOB' : null,
                ),
                const SizedBox(height: 16),

                // Description (Text Area)
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (Teaching Experience, etc.)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12)), // More rounded
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                // CV File Upload
                OutlinedButton(
                  onPressed: _pickCVFile,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue), // Blue border
                    foregroundColor: Colors.blue, // Blue text
                  ),
                  child: const Text('Upload CV (PDF/DOC)'),
                ),
                const SizedBox(height: 8),
                Text(
                  _cvFile?.name ?? 'No file selected',
                  style: TextStyle(
                      color: _cvFile == null ? Colors.grey : Colors.black),
                ),
                const SizedBox(height: 16),

                // Agreement Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      onChanged: (bool? value) =>
                          setState(() => _isAgreed = value ?? false),
                    ),
                    const Expanded(
                      child: Text('I agree to the terms and policies.'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Makes the button blue
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Apply Instructor',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
