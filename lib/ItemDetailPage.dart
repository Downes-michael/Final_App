import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  ItemDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NBA Team Details'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'lib/assets/${item['id']}.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            _buildDetailRow('ID', item['id'].toString()),
            _buildDetailRow('Abbreviation', item['abbreviation']),
            _buildDetailRow('City', item['city']),
            _buildDetailRow('Conference', item['conference']),
            _buildDetailRow('Division', item['division']),
            _buildDetailRow('Full Name', item['full_name']),
            _buildDetailRow('Name', item['name']),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back to the main page
          },
          child: Text('Back to Main Page'),
        ),
      ),
    );
  }

//customize the text being displayed
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
