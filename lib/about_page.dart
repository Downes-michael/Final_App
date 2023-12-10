import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downes App About Page'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "In addition to its user-friendly interface and time-saving capabilities, the DownesApp stands out with its versatile customization options, allowing users to tailor lists and items to their unique preferences and needs.\n\n This innovative application goes beyond traditional list management by incorporating advanced organizational features that empower users to categorize, prioritize, and efficiently navigate through their tasks. Seamlessly integrating into your daily routine, the DownesApp also offers a range of collaborative tools, making it an ideal solution for team projects and group tasks.\n\n Furthermore, its intuitive design ensures a smooth and enjoyable user experience, fostering a sense of productivity and control over your daily responsibilities. Elevate your organizational prowess with the DownesApp – the ultimate companion for those seeking a comprehensive and efficient approach to task management.",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16.0),
            ),
            Spacer(),
            Text(
              'Developed by Michael Downes for CMSC 2204',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
