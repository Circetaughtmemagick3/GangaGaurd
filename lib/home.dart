import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jalshakti/auth/profile.dart';
import 'package:jalshakti/rakshak.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GangaGuard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    RakshakChatbotPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('GangaGuard'),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      drawer: _buildDrawer(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.person, color: Colors.blue.shade900),
              title: Text('My Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage()), // Replace 'ProfilePage' with the actual page class
                );
              }),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.blue.shade900),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement logout logic
            },
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWarningBand(),
          _buildLocationInfo(), // Moved warning band to the top
          WeeklyDischargeGraph(),
          _buildWeatherInfo(),
          _buildGangaRiverBasinSection(),
        ],
      ),
    );
  }

  Widget _buildWarningBand() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.orange,
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Heavy rainfall expected in the next 24 hours',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue.shade900),
          SizedBox(width: 10),
          Text(
            'New Delhi, India',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return Container(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: List.generate(5, (index) {
          return _buildWeatherTile();
        }),
      ),
    );
  }

  Widget _buildWeatherTile() {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors
                  .blue.shade900, // Matching the color with "Ganga River Basin"
            ),
          ),
          SizedBox(height: 8),
          _buildTileRow(Icons.thermostat, 'Temp', '28°C'),
          _buildTileRow(Icons.water_drop, 'Humidity', '80%'),
          _buildTileRow(Icons.umbrella, 'Rain', '60%'),
        ],
      ),
    );
  }

  Widget _buildTileRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 18),
          SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGangaRiverBasinSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Ganga River Basin',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        ),
        Container(
          height: 200, // Increased the height of the river tiles
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: List.generate(10, (index) {
              return _buildGangaRiverDataTile();
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildGangaRiverDataTile() {
    return Container(
      width: 180, // Increased the width of the river tiles
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('River Data',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900)),
          SizedBox(height: 5),
          _buildTileRow(Icons.waves, 'Flow', '1600 m³/s'),
          _buildTileRow(Icons.opacity, 'BOD', '3.2 mg/L'),
          _buildTileRow(Icons.scatter_plot, 'Pollution', '450 MLD'),
          _buildTileRow(Icons.filter_alt, 'DO', '7.5 mg/L'),
        ],
      ),
    );
  }
}

class WeeklyDischargeGraph extends StatelessWidget {
  final List<FlSpot> dischargeData = [
    FlSpot(0, 1500),
    FlSpot(1, 1600),
    FlSpot(2, 1550),
    FlSpot(3, 1700),
    FlSpot(4, 1800),
    FlSpot(5, 1650),
    FlSpot(6, 1550),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Increased the size of the graph
      padding: EdgeInsets.all(16),
      child: Card(
        color: Colors.white, // Set background to white
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Discharge',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            String text = '';
                            switch (value.toInt()) {
                              case 0:
                                text = 'Mon';
                                break;
                              case 1:
                                text = 'Tue';
                                break;
                              case 2:
                                text = 'Wed';
                                break;
                              case 3:
                                text = 'Thu';
                                break;
                              case 4:
                                text = 'Fri';
                                break;
                              case 5:
                                text = 'Sat';
                                break;
                              case 6:
                                text = 'Sun';
                                break;
                            }
                            return Text(text);
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 6,
                    minY: 1000,
                    maxY: 2000,
                    lineBarsData: [
                      LineChartBarData(
                        spots: dischargeData,
                        isCurved: true,
                        color: Colors.blue.shade900,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
