import 'package:converter_app/calculator/index.dart';
import 'package:converter_app/pages/area.dart';
import 'package:converter_app/pages/length.dart';
import 'package:converter_app/pages/temperature.dart';
import 'package:converter_app/pages/volume.dart';
import 'package:converter_app/pages/weight.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) => MaterialApp(
        title: 'All Converter',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFE0E5EC),
          useMaterial3: true,
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Calculator(),
    LengthConverterPage(),
    WeightConverterPage(),
    TemperatureConverterPage(),
    VolumeConverterPage(),
    AreaConverterPage(),
  ];

  BoxDecoration _neumorphicBox() {
    return BoxDecoration(
      color: Color(0xFFE0E5EC),
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          offset: Offset(-5, -5),
          blurRadius: 15,
        ),
        BoxShadow(
          color: Color(0xFFA3B1C6),
          offset: Offset(5, 5),
          blurRadius: 15,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Converter',
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600)),
        titleTextStyle: TextStyle(
            fontSize: 22.sp, fontWeight: FontWeight.w600, color: Colors.white),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 49, 68, 97),
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: _neumorphicBox(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: GNav(
              gap: 10,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              color: Colors.grey[700],
              activeColor: Colors.white,
              tabBackgroundColor: Color.fromARGB(255, 49, 68, 97),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              tabs: [
                GButton(icon: Icons.calculate_outlined, text: 'Calculator'),
                GButton(icon: Icons.straighten_outlined, text: 'Length'),
                GButton(icon: Icons.thermostat_outlined, text: 'Weight'),
                GButton(icon: Icons.local_drink_outlined, text: 'Temperature'),
                GButton(icon: Icons.equalizer_outlined, text: 'Volume'),
                GButton(icon: Icons.square_foot_outlined, text: 'Area'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
