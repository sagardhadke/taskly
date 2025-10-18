import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/core/constants/table_keys.dart';
import 'package:taskly/provider/list_provider.dart';
import 'package:taskly/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDataLoading = true;

  @override
  void initState() {
    super.initState();
    loadTask();
  }

  Future<void> loadTask() async {
    await Provider.of<ListProvider>(context, listen: false).fetchAllNote();
    setState(() {
      isDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Taskly",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: isDataLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
              ),
            )
          : Consumer<ListProvider>(
              builder: (context, provider, child) {
                return provider.allNotes.isNotEmpty
                    ? ListView.builder(
                        itemCount: provider.allNotes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              provider.allNotes[index][TableKeys.noteTitle],
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              provider.allNotes[index][TableKeys
                                  .noteDescription],
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.editNote,
                                    arguments: {
                                      'isUpdate': true,
                                      'title': provider
                                          .allNotes[index][TableKeys.noteTitle],
                                      'desc':
                                          provider.allNotes[index][TableKeys
                                              .noteDescription],
                                      'noteId': provider
                                          .allNotes[index][TableKeys.noteId],
                                    },
                                  ),
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    provider.deleteNote(
                                      noteId: provider
                                          .allNotes[index][TableKeys.noteId],
                                    );
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [
                            Image.asset("assets/noNote.png", height: 150),
                            Text(
                              "No Notes Yet!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Start by adding your first note.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.editNote,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(
                                  0XFF158976,
                                ).withValues(alpha: 0.75),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Add Note"),
                            ),
                          ],
                        ),
                      );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.editNote),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text("Add Note"),
      ),
    );
  }
}
