import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminSuggestionAddPage extends StatefulWidget {
  const AdminSuggestionAddPage({super.key});

  @override
  _AdminSuggestionAddPageState createState() => _AdminSuggestionAddPageState();
}

class _AdminSuggestionAddPageState extends State<AdminSuggestionAddPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController resourceController = TextEditingController();

  List<String> resources = []; // List to store multiple resources

  Future<void> addSuggestion() async {
    if (categoryController.text.isEmpty ||
        titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        resources.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields and add at least one resource.")),
      );
      return;
    }

    final suggestionData = {
      'title': titleController.text,
      'description': descriptionController.text,
      'resources': resources,
    };

    // Save to Firestore under the "suggestions" collection with the category name as document ID
    await firestore.collection('suggestions').doc(categoryController.text).set(suggestionData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Suggestion added successfully!")),
    );

    // Clear all fields after submission
    categoryController.clear();
    titleController.clear();
    descriptionController.clear();
    resourceController.clear();
    resources.clear();
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 25,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white70,
        title:  Text("Add Suggestion",  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 24),),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: categoryController,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),
                  hintText: "Enter category (e.g., Math, Science)",
                  hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black),
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),

                  hintText: "Enter suggestion title",
                  hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black),
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "Enter suggestion description",
                  labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),
                    hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                "Resources",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 5,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text(resources[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            resources.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black),
                      controller: resourceController,
                      decoration: const InputDecoration(
                        labelText: "Add Resource",
                        labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),
                          hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),
                        hintText: "Enter a link or resource",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      if (resourceController.text.isNotEmpty) {
                        setState(() {
                          resources.add(resourceController.text);
                        });
                        resourceController.clear();
                      }
                    },
                    child: const Text("Add",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: Colors.white),),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  onPressed: addSuggestion,
                  child: const Text("Save Suggestion",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
