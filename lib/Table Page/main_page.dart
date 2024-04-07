import 'package:flutter/material.dart';
import 'package:nthu_tracker/Table%20Page/overview.dart';
import 'package:nthu_tracker/Table%20Page/table.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<String> _titles = [
    'TABLE',
    'CHECKLISTS',
    'TIMER',
    'CHART',
    'PROFILE',
  ];

  final List<Widget> _pages = [
    Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
    const Page5(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _titles[_currentIndex],
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_on,
              color: Colors.black,
            ),
            label: 'TABLE',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box,
              color: Colors.black,
            ),
            label: 'CHECKLISTS',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.hourglass_full,
              color: Colors.black,
            ),
            label: 'TIMER',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.insert_chart,
              color: Colors.black,
            ),
            label: 'CHART',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int current = 0;
  List<String> tabs = ["Lists", "Overview"];

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 0;
      case 1:
        return 78;

      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (current) {
      case 0:
        return 50;
      case 1:
        return 80;

      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 10 : 43, top: 7),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              fontSize: current == index ? 16 : 14,
                              fontWeight: current == index
                                  ? FontWeight.w400
                                  : FontWeight.w300,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: 0,
                left: changePositionedOfLine(),
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 500),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: changeContainerWidth(),
                  height: MediaQuery.of(context).size.height * 0.008,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurpleAccent),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageStorage(
            bucket: PageStorageBucket(),
            child: IndexedStack(
              index: current,
              children: [
                CourseTable(key: PageStorageKey('Page1')),
                CourseOverview(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 3'),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 4'),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 5'),
    );
  }
}
