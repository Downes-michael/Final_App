import 'dart:convert';
import 'package:final_project/ItemDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://www.balldontlie.io/api/v1/";

// Create a base client class
class BaseClient {
  var client = http.Client();
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ItemListPage(),
    );
  }
}

class ItemListPage extends StatefulWidget {
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  bool isLoading = false;
  List<Map<String, dynamic>> items = [];
  BaseClient baseClient = BaseClient(); // Create an instance of the BaseClient
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Use the baseClient to make the HTTP request
      final response = await baseClient.get('teams');
      final List<dynamic> responseData = json.decode(response)['data'];
      setState(() {
        items = responseData.cast<Map<String, dynamic>>();
      });
      _scrollController.jumpTo(0.0);
    } catch (error) {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load items: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NBA Teams List'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Team ID: ${item['id']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailText(
                        'NBA Team Abbreviation', item['abbreviation']),
                    _buildDetailText('City', item['city']),
                    //_buildDetailText('Conference', item['conference']),
                    //_buildDetailText('Division', item['division']),
                    //_buildDetailText('Full Name', item['full_name']),
                    _buildDetailText('Name', item['name']),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      //go to detail page
                      builder: (context) => ItemDetailPage(item: item),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await _fetchItems();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Content Refreshed'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          tooltip: 'Reload',
          child: Visibility(
            visible: isLoading,
            child: CircularProgressIndicator(),
            replacement: Icon(Icons.refresh),
          )),
    );
  }

//style the text
  Widget _buildDetailText(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: $value',
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }
}
