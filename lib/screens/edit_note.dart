import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/provider/list_provider.dart';
import 'package:taskly/widget/custom_text_filed.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  int? noteId;
  bool isUpdate = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController mTitle = TextEditingController();
  TextEditingController mDesc = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      isUpdate = args['isUpdate'] ?? false;
      mTitle.text = args['title'] ?? '';
      mDesc.text = args['desc'] ?? '';
      noteId = args['noteId'];
    }
  }

  @override
  void dispose() {
    mTitle.dispose();
    mDesc.dispose();
    super.dispose();
  }

  void _handleFormSubmit(ListProvider provider) {
    if (formKey.currentState!.validate()) {
      if (isUpdate) {
        provider.updateNote(
          title: mTitle.text.trim(),
          desc: mDesc.text.trim(),
          noteId: noteId!,
        );
      } else {
        provider.addNote(title: mTitle.text.trim(), desc: mDesc.text.trim());
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Edit Note Build Called");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? "Update Note" : "Add Note",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Consumer<ListProvider>(
        builder: (context, provider, child) {
          print("Edit Note Consumer Build Called");
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: "Title",
                    hint: "Enter note title",
                    controller: mTitle,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Title is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    label: "Description",
                    hint: "Enter note description",
                    controller: mDesc,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Description is required";
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _handleFormSubmit(provider),
                      icon: Icon(isUpdate ? Icons.edit : Icons.add),
                      label: Text(isUpdate ? "Update Note" : "Add Note"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
