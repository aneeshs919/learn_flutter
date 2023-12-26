import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

Future<Map<String, dynamic>> fetchData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

  // Print the entire response to the console
  print('Response: ${response.statusCode}');
  print('Headers: ${response.headers}');
  print('Body: ${response.body}');

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    // Print the parsed JSON data
    print('Parsed JSON: $jsonData');
    return jsonData;
  } else {
    throw Exception('Failed to load data');
  }
}

void main() {
  runApp(MyApp());
}

Map<String, bool> optionsState = {
  'Option 1': false,
  'Option 2': false,
  // Add more options as needed
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              kToolbarHeight + 4.0), // Adjust the height as needed
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 4, // Blur radius
                  offset: Offset(0, 2), // Offset in x and y directions
                ),
              ],
            ),
            child: AppBar(
              leading: FlutterLogo(size: 36.0), // Add Flutter logo to the left
              title: Text(
                'NestAway App',
                style:
                    TextStyle(fontSize: 16.0), // Adjust the font size as needed
              ),
              elevation: 0.0, // Set the elevation of the AppBar to 0.0
              titleSpacing: 0.0, // Align title to the left
            ),
          ),
        ),
        body: MyListView(),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.user,
    required this.viewCount,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Item tapped');
        // Add your onTap logic for the entire card here
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: thumbnail,
                  ),
                  Expanded(
                    flex: 3,
                    child: _VideoDescription(
                      title: title,
                      user: user,
                      viewCount: viewCount,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showMoreOptions(context);
                    },
                    child: const Icon(
                      Icons.more_vert,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(top: 16.0), // Add top padding as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Your other widgets
                        _ActionButtons(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showMoreOptions(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MoreOptions();
      });
}

class MoreOptions extends StatefulWidget {
  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  late Future<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // print('Title: $futureAlbum.title');
    print('Body333: ${data}');

    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: optionsState.keys.map((String option) {
          return CheckboxListTile(
            title: Text(option),
            value: optionsState[option],
            onChanged: (bool? value) {
              setState(() {
                optionsState[option] = value ?? false;
              });
            },
          );
        }).toList(),
      ),
    ));
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    required this.title,
    required this.user,
    required this.viewCount,
  });

  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$viewCount views',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double buttonSpacing = 8.0;
    return Row(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            // Add your search action logic here
          },
          child: const Icon(
            Icons.search,
            size: 16.0,
          ),
        ),
        SizedBox(width: buttonSpacing),
        ElevatedButton(
          onPressed: () {
            // Add your notifications action logic here
          },
          child: const Icon(
            Icons.notifications,
            size: 16.0,
          ),
        ),
        SizedBox(width: buttonSpacing),
        ElevatedButton(
          onPressed: () {
            // Add your settings action logic here
          },
          child: const Icon(
            Icons.settings,
            size: 16.0,
          ),
        ),
        SizedBox(width: buttonSpacing),
        ElevatedButton(
          onPressed: () {
            // Add your profile action logic here
          },
          child: const Icon(
            Icons.person,
            size: 16.0,
          ),
        ),
      ],
    );
  }
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <CustomListItem>[
        CustomListItem(
          user: 'Flutter',
          viewCount: 999000,
          thumbnail: Container(
            width: 100.0, // Replace with your desired width
            height: 100.0, // Replace with your desired height
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          title: 'The Flutter YouTube Channel',
        ),
        CustomListItem(
          user: 'Dash',
          viewCount: 884000,
          thumbnail: Container(
            width: 100.0, // Replace with your desired width
            height: 100.0, // Replace with your desired height
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          title: 'Announcing Flutter 1.0',
        ),
      ],
    );
    // ListTile(
    //   leading: Icon(Icons.star),
    //   title: Text('Item 1'),
    //   subtitle: Text('Description for Item 1'),
    //   onTap: () {
    //     // Handle item tap for Item 1
    //     print('Item 1 tapped');
    //   },
    // ),
    // ListTile(
    //   leading: Icon(Icons.star),
    //   title: Text('Item 2'),
    //   subtitle: Text('Description for Item 2'),
    //   onTap: () {
    //     // Handle item tap for Item 2
    //     print('Item 2 tapped');
    //   },
    // ),
    // ListTile(
    //   leading: Icon(Icons.star),
    //   title: Text('Item 3'),
    //   subtitle: Text('Description for Item 3'),
    //   onTap: () {
    //     // Handle item tap for Item 3
    //     print('Item 3 tapped');
    //   },
    // ),
    // Add more ListTiles as needed
  }
}
