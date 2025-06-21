import 'package:demo/core/util/my_theme.dart';
import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/page_detail_model.dart';
import 'package:demo/screens/ask-question/ask_question.dart';
import 'package:demo/screens/community/community.dart';
import 'package:demo/screens/course/course.dart';
import 'package:demo/screens/homescreen/home.dart';
import 'package:demo/screens/menu/menu.dart';
import 'package:demo/screens/messager/messager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late final http.Client client;
  late final ApiClient apiClient;
  PageDetailModel? _pageDetail;

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const HomeScreen(),
    const MessagerScreen(),
    CommunityScreen(),
    const CourseScreen(),
    const MenuScreen()
  ];

  final List<String> _appBarNames = [
    'Home',
    'Messager',
    'Community',
    'Courses',
    'Menu'
  ];

  @override
  void initState() {
    super.initState();
    client = http.Client();
    apiClient = ApiClient(client: client);
    getPageDetail();
  }

  getPageDetail() async {
    try {
      final response = await apiClient.onGetPageDetail(arg: {});
      if (response.status == "success") {
        setState(() {
          _pageDetail = response.records!;
          print(_pageDetail);
        });
      } else {
        print("Fetch Data Failed: ${response.msg}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showPopupMenu(BuildContext context) {
    String selectedCategory = 'All'; // Default value for Category dropdown
    String selectedTechnology = 'All'; // Default value for Technology dropdown

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/images/e-learning.png'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Luon Verak',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@l_verak',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                // Filter Section (Column of Combo Boxes)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedTechnology,
                        decoration: const InputDecoration(
                          labelText: 'Technology',
                          border: OutlineInputBorder(),
                        ),
                        items: <String>[
                          'All',
                          'Flutter',
                          'React',
                          'Angular',
                          'Vue',
                          'Java Spring'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            selectedTechnology = newValue;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: <String>[
                          'All',
                          'Web',
                          'Mobile',
                          'Backend',
                          'Frontend'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            selectedCategory = newValue;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Sort By',
                          border: OutlineInputBorder(),
                        ),
                        items: <String>[
                          'All',
                          'Web',
                          'Mobile',
                          'Backend',
                          'Frontend'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            selectedCategory = newValue;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle filter action
                    print(
                        'Category: $selectedCategory, Technology: $selectedTechnology');
                    Navigator.pop(context); // Close the modal
                  },
                  child: const Text('Apply Filter'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bodyBackground,
      appBar: _currentIndex != 4
          ? AppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.white,
              leadingWidth: 80,
              leading: Container(
                margin: EdgeInsets.only(left: MyTheme.addBarSpace),
                child: SizedBox(
                  height: 60,
                  child: _pageDetail == null
                      ? Center(
                          child: CircularProgressIndicator()) // keep centered
                      : Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.network(
                              _pageDetail!.logo.replaceAll(
                                  '192.168.58.239:8080', '10.0.2.2:8000'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              title: Text(
                _appBarNames[_currentIndex],
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          (_currentIndex != 1)
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    print('Search pressed');
                                  },
                                )
                              : Container(),
                          (_currentIndex != 1 && _currentIndex != 2)
                              ? (_currentIndex != 3)
                                  ? Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.notifications,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            print('Notifications pressed');
                                          },
                                        ),
                                        Positioned(
                                          right: 6,
                                          top: 6,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 18,
                                              minHeight: 18,
                                            ),
                                            child: const Text(
                                              '0',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.filter_list,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        _showPopupMenu(context);
                                      },
                                    )
                              : Container()
                        ],
                      )
                    ],
                  ),
                ),
              ],
              elevation: 0,
            )
          : PreferredSize(
              preferredSize:
                  const Size.fromHeight(15.0), // Set the height of the AppBar
              child: AppBar(
                backgroundColor: Colors.blue,
              ),
            ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: _currentIndex == 2
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DataInsertScreen(), // Replace with your actual screen
                  ),
                );
              },
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.question_mark,
                color: Colors.white,
              ),
              tooltip: 'Ask a new question',
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Stack(children: [
                const Icon(Icons.chat),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: const Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]),
            ),
            label: 'Chat',
          ),
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Icon(Icons.group),
            ),
            label: 'Community',
          ),
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Icon(Icons.book),
            ),
            label: 'Course',
          ),
          const BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Icon(Icons.menu_open),
            ),
            label: 'Menu',
          ),
        ],
        currentIndex: _currentIndex, // Highlight the selected item
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.grey.shade500,
        selectedFontSize: 15, // Increase font size for selected label
        unselectedFontSize: 12, // Increase font size for unselected labels
        iconSize: 30,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
