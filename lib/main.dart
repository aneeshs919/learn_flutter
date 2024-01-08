import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

Future<Map<String, dynamic>> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/40761f22-97d6-4ebd-bb69-77ce78cc7914'));

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
    required this.status,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String user;
  final int viewCount;
  final String status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Item tapped');
        // Add your onTap logic for the entire card here
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // IconButton in the same row
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Handle button press
            },
          ),
          // Card in the same row
          Expanded(
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
                            status: status,
                            title: title,
                            user: user,
                            viewCount: viewCount,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: 16.0), // Add top padding as needed
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
          ),
        ],
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
  @override
  Widget build(BuildContext context) {
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
    required this.status,
  });

  final String title;
  final String user;
  final int viewCount;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            status,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Colors.blue),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
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
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<CustomListItem> data = snapshot.data as List<CustomListItem>;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return CustomListItem(
                status: data[index].status,
                user: data[index].user,
                viewCount: data[index].viewCount,
                thumbnail: data[index].thumbnail,
                title: data[index].title,
              );
            },
          );
        }
      },
    );
  }

  Future<List<CustomListItem>> fetchData() async {
    final response = await http.get(
      Uri.parse('https://run.mocky.io/v3/40761f22-97d6-4ebd-bb69-77ce78cc7914'),
    );

    if (response.statusCode == 200) {
      // Parse JSON data
      List<dynamic> apiData = jsonDecode(response.body);
      List<CustomListItem> data = apiData.map((item) {
        return CustomListItem(
          status: item['status'],
          user: item['start_time'],
          viewCount: item['event_id'],
          thumbnail: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          title: item['title'],
        );
      }).toList();
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
  // @override
  // Widget build(BuildContext context) {
  //   return ListView(
  //     children: <CustomListItem>[
  //       CustomListItem(
  //         user: 'Flutter',
  //         viewCount: 999000,
  //         thumbnail: Container(
  //           width: 100.0, // Replace with your desired width
  //           height: 100.0, // Replace with your desired height
  //           decoration: BoxDecoration(
  //             color: Colors.blue,
  //           ),
  //         ),
  //         title: 'The Flutter YouTube Channel',
  //       ),
  //       CustomListItem(
  //         user: 'Dash',
  //         viewCount: 884000,
  //         thumbnail: Container(
  //           width: 100.0, // Replace with your desired width
  //           height: 100.0, // Replace with your desired height
  //           decoration: BoxDecoration(
  //             color: Colors.blue,
  //           ),
  //         ),
  //         title: 'Announcing Flutter 1.0',
  //       ),
  //     ],
  //   );
  // }
}
