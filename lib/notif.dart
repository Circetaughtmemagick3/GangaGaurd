import 'package:flutter/material.dart';

class Notifpage extends StatefulWidget {
  @override
  _NotifpageState createState() => _NotifpageState();
}

class _NotifpageState extends State<Notifpage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    AlertFeed(),
    Center(child: Text('Notifications')),
    Center(child: Text('Chat')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      drawer: _buildDrawer(),
      body: _pages[_currentIndex], // Keep only the body content
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
              'GangaGuard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle the tap
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              // Handle the tap
            },
          ),
        ],
      ),
    );
  }
}

class AlertFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AlertCard(
          title: 'Heavy Rainfall Warning in Delhi',
          description:
              'Expect heavy rainfall in Delhi over the next 24 hours. Stay indoors if possible.',
          imageUrl:
              'https://images.unsplash.com/photo-1534274988757-a28bf1a57c17?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
          severity: AlertSeverity.high,
          authorityHandle: 'Delhi Weather',
          datePosted: DateTime.now().subtract(Duration(hours: 2)),
        ),
        AlertCard(
          title: 'Flood Alert in Ganga Basin',
          description:
              'Flood alert issued for XYZ village in the Ganga basin. Residents advised to stay vigilant.',
          imageUrl:
              'https://images.unsplash.com/photo-1547683905-f686c993aae5?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
          severity: AlertSeverity.critical,
          authorityHandle: 'Ganga Flood Control',
          datePosted: DateTime.now().subtract(Duration(minutes: 45)),
        ),
        AlertCard(
          title: 'Cyclone Warning',
          description:
              'Cyclone approaching the eastern coast. Prepare for strong winds and heavy rain.',
          imageUrl:
              'https://images.unsplash.com/photo-1527482797697-8795b05a13fe?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
          severity: AlertSeverity.critical,
          authorityHandle: 'Indian Meteorological Dept',
          datePosted: DateTime.now().subtract(Duration(days: 1)),
        ),
      ],
    );
  }
}

enum AlertSeverity { low, medium, high, critical }

class AlertCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final AlertSeverity severity;
  final String authorityHandle;
  final DateTime datePosted;

  const AlertCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.severity,
    required this.authorityHandle,
    required this.datePosted,
  }) : super(key: key);

  Color _getSeverityColor() {
    switch (severity) {
      case AlertSeverity.low:
        return Colors.green;
      case AlertSeverity.medium:
        return Colors.yellow;
      case AlertSeverity.high:
        return Colors.orange;
      case AlertSeverity.critical:
        return Colors.red;
    }
  }

  String _getTimeAgo() {
    final difference = DateTime.now().difference(datePosted);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade900,
                  child: Icon(Icons.verified, color: Colors.white, size: 20),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorityHandle,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '@${authorityHandle.toLowerCase().replaceAll(' ', '_')}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Text(
                  _getTimeAgo(),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Image.network(imageUrl,
              height: 200, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, color: _getSeverityColor()),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(description),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.reply), onPressed: () {}),
                    IconButton(icon: Icon(Icons.repeat), onPressed: () {}),
                    IconButton(icon: Icon(Icons.share), onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
