import 'package:flutter/material.dart';
import 'package:naijaruns/helpers/env.dart';
import 'package:naijaruns/pages/upload.dart';
import 'package:naijaruns/pages/videos.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PageController controller = PageController();

  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          label: 'Home'
      ),
      BottomNavigationBarItem(
          icon: new Icon(Icons.diamond_outlined),
          label: 'Spotlight'
      ),
      BottomNavigationBarItem(
          icon: new Icon(Icons.add),
          label: 'Upload'
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.chat),
        label: 'Chat',
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings'
      )
    ];
  }

  List<String> pageTitles = [
    'Home', 'Spotlight', 'Upload', 'Chat', 'Settings'
  ];
  String currentTitle = 'Home';
  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      currentTitle = pageTitles[index];
      controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  List<Widget> _list=<Widget>[
    new Center(child:new VideoPage()),
    new Center(child:new Pages(text: "Page 2",)),
    new Center(child:new UploadPage()),
    new Center(child:new Pages(text: "Page 4",)),
    new Center(child:new Pages(text: "Page 5",))
  ];
  int _curr=0;

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      currentTitle = pageTitles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar:AppBar(
          title: Text(currentTitle),
          backgroundColor: primaryColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.notifications),
              ),
            )
          ],),
        body: PageView(
          children:
          _list,
          scrollDirection: Axis.horizontal,

          // reverse: true,
          // physics: BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (index){
            pageChanged(index);
          },
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting, // Shifting
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            bottomTapped(index);
          },
          currentIndex: bottomSelectedIndex,
          items: buildBottomNavBarItems(),
        ),
    );
  }
}

class Pages extends StatelessWidget {
  final text;
  Pages({this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text(text,textAlign: TextAlign.center,style: TextStyle(
                fontSize: 30,fontWeight:FontWeight.bold),),
          ]
      ),
    );
  }
}
