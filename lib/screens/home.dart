import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/localization/locales.dart';
import 'package:flutter_application_1/screens/add_item.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchTasks();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleData.title.getString(context)),
          actions: [
            DropdownButton(
              value: _currentLocale,
              items: const [
                DropdownMenuItem(
                  value: "en",
                  child: Text("English"),
                ),
                DropdownMenuItem(
                  value: "uk",
                  child: Text("Українська"),
                ),
              ],
              onChanged: (value) {
                _setLocale(value);
              },
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green], // Add your desired colors
            ),
          ),
          child: Visibility(
            visible: isLoading,
            replacement: RefreshIndicator(
              onRefresh: fetchTasks,
              child: Visibility(
                visible: items.isNotEmpty,
                replacement:
                    Center(child: Text(LocaleData.noItems.getString(context))),
                child: ListView.builder(
                    itemCount: items.length,
                    // padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final item = items[index] as Map;
                      final id = item['_id'] as String;
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color.fromARGB(255, 163, 212,
                                255), // Set the button's background color to blue
                            foregroundColor: const Color.fromARGB(
                                255, 3, 0, 39), // Set the text color to white
                            child: Text('${index + 1}'),
                          ),
                          title: Text(item['title']),
                          subtitle: Text(item['description']),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                            if (value == 'edit') {
                              navigateToEditItems(item);
                            } else if (value == 'delete') {
                              deleteById(id);
                            }
                          },
                          itemBuilder: (context) => [
                             PopupMenuItem<String>(
                                value: 'edit',
                                child: Text(
                                    LocaleData.editTask.getString(context)),
                              ),
                              PopupMenuItem(
                                  value: 'delete',
                                  child: Text(
                                      LocaleData.delete.getString(context))
                            
                              ),
                            ]
                          ),
                        ),
                      );
                    }
                  ),
                ),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
          floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddItems,
          label: Text(LocaleData.floatingButton.getString(context)),
          backgroundColor: const Color.fromARGB(
              255, 229, 243, 255), // Set the button's background color to blue
          foregroundColor:
              const Color.fromARGB(255, 3, 0, 39), // Set the text color to white
        ));
  }

  Future<void> navigateToAddItems() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTasks();
  }

  Future<void> navigateToEditItems(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );

    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTasks();
  }

  void showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showMessage('Delation Failed');
    }
  }

  Future<void> fetchTasks() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "uk") {
      _flutterLocalization.translate("uk");
    } else {
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }
}
