import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Ensure this import is in place
import 'package:jalshakti/auth/profile.dart';
import 'package:jalshakti/notif.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/notif': (context) => Notifpage(),
        '/chat': (context) => RakshakChatbotPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => HomePage(), // Default route
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

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
      drawer: _buildDrawer(context),
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue.shade900,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeContent();
      case 1:
        return Notifpage();
      case 2:
        return RakshakChatbotPage();
      default:
        return HomeContent();
    }
  }

  Widget _buildDrawer(BuildContext context) {
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
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.blue.shade900),
            title: Text('Logout'),
            onTap: () {
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
          _buildLocationInfo(),
          WeeklyDischargeGraph(),
          _buildFloodInfo(),
          _buildMostPollutedSection(),
          _buildWeatherForecastSection(),
          _buildGangaRiverBasinSection(),
          SizedBox(
            height: 20,
          )
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

  Widget _buildWeatherForecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Weather Forecast',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        ),
        Container(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: List.generate(5, (index) {
              return _buildWeatherTile();
            }),
          ),
        ),
      ],
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
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '${DateTime.now().day}/${DateTime.now().month}, ${DateTime.now().hour}:${DateTime.now().minute}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
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

Widget _buildMostPollutedSection() {
  return Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most Polluted Area',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Location:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red.shade700,
              ),
            ),
            Text(
              'Kanpur, Uttar Pradesh',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pollution Level:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red.shade700,
              ),
            ),
            Text(
              'Severe',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFloodInfo() {
  return Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flood Alert',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chance of Flood:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade700,
              ),
            ),
            Text(
              '60%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Location:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade700,
              ),
            ),
            Text(
              'Varanasi, Uttar Pradesh',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class WeeklyDischargeGraph extends StatelessWidget {
  final List<FlSpot> runoffData = [
    FlSpot(0, 1500),
    FlSpot(1, 1600),
    FlSpot(2, 1550),
    FlSpot(3, 1700),
    FlSpot(4, 1800),
    FlSpot(5, 1650),
    FlSpot(6, 1550),
  ];

  final List<FlSpot> dischargeData = [
    FlSpot(0, 1300),
    FlSpot(1, 1400),
    FlSpot(2, 1450),
    FlSpot(3, 1600),
    FlSpot(4, 1700),
    FlSpot(5, 1550),
    FlSpot(6, 1450),
  ];

  final List<FlSpot> floodMagnitudeData = [
    FlSpot(0, 100),
    FlSpot(1, 120),
    FlSpot(2, 110),
    FlSpot(3, 150),
    FlSpot(4, 180),
    FlSpot(5, 140),
    FlSpot(6, 130),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350, // Reduced height to prevent overflow
      padding: EdgeInsets.all(16),
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly River Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.blue.withOpacity(0.1),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.blue.withOpacity(0.1),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${value.toInt()}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            const days = [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun'
                            ];
                            return Text(
                              days[value.toInt()],
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(
                        show: true, border: Border.all(color: Colors.black12)),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 2000,
                    lineBarsData: [
                      _lineChartBarData(runoffData, Colors.blue),
                      _lineChartBarData(dischargeData, Colors.green),
                      _lineChartBarData(floodMagnitudeData, Colors.red),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Runoff', Colors.blue),
                  SizedBox(width: 20),
                  _buildLegendItem('Discharge', Colors.green),
                  SizedBox(width: 20),
                  _buildLegendItem('Flood Magnitude', Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartBarData _lineChartBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
