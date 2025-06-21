import 'package:flutter/material.dart';

class DataInsertScreen extends StatefulWidget {
  @override
  _DataInsertScreenState createState() => _DataInsertScreenState();
}

class _DataInsertScreenState extends State<DataInsertScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TextEditingController> tagControllers = [TextEditingController()];
  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Data'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Tags:', style: TextStyle(fontWeight: FontWeight.bold)),
              ..._buildTagFields(),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    tagControllers.add(TextEditingController());
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Images:', style: TextStyle(fontWeight: FontWeight.bold)),
              // Image upload functionality would go here
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTagFields() {
    return List<Widget>.generate(tagControllers.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: tagControllers[index],
                decoration: InputDecoration(
                  labelText: 'Tag ${index + 1}',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            if (index > 0)
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    tagControllers.removeAt(index);
                  });
                },
              ),
          ],
        ),
      );
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process data
      final data = {
        'title': titleController.text,
        'description': descriptionController.text,
        'tags': tagControllers.map((c) => c.text).toList(),
        'images': images,
      };

      // Here you would typically send this data to your backend
      print('Submitted data: $data');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data submitted successfully')),
      );
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    titleController.dispose();
    descriptionController.dispose();
    for (var controller in tagControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
