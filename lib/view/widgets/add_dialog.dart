// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/home_controller.dart';
import 'package:totalx/model/data_model.dart';

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({super.key});

  @override
  _AddUserWidgetState createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  final formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _ageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context, listen: false);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<UserController>(
              builder: (context, value, child) => GestureDetector(
                onTap: () => value.pickImageFromGallery(),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: value.pickedImage != null
                      ? FileImage(value.pickedImage!)
                      : null,
                  child: value.pickedImage == null
                      ? const Icon(Icons.person)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add A New User',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              focusNode: _nameFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter Name";
                }
                return null;
              },
              controller: provider.nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_ageFocusNode);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              focusNode: _ageFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter Age";
                }
                return null;
              },
              controller: provider.ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 236, 235, 235),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007bff),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 13,
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addData(context);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addData(BuildContext context) async {
  final provider = Provider.of<UserController>(context, listen: false);
  final user = DataModel(
    name:provider. nameController.text,
    age: int.parse(provider.ageController.text),
    image: provider.uploadedImageUrl

  );
  await provider.addUser(user);
}
}
