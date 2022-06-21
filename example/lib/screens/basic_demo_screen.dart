import 'package:example/screens/custom_demo_screen.dart';
import 'package:example/screens/event_demo_screen.dart';
import 'package:example/screens/multiple_demo_screen.dart';
import 'package:example/screens/range_demo_screen.dart';
import 'package:example/screens/single_demo_screen.dart';
import 'package:flutter/material.dart';

class BasicDemoScreen extends StatelessWidget {
  const BasicDemoScreen({Key? key}) : super(key: key);

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: const FlutterLogo(size: 72.0),
        title: Text(title),
        subtitle: Text(subtitle),
        isThreeLine: true,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo flutter_calendar_widget'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _buildListTile(
              title: 'Single demo screen',
              subtitle: 'A demo of the widget that selects only one date.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SingleDemoScreen(),
                ),
              ),
            ),
            _buildListTile(
              title: 'Range demo screen',
              subtitle: 'A demo of the widget that selects range date.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RangeDemoScreen(),
                ),
              ),
            ),
            _buildListTile(
              title: 'Multiple demo screen',
              subtitle: 'A demo of the widget that selects multiple dates.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MultipleDemoScreen(),
                ),
              ),
            ),
            _buildListTile(
              title: 'Custom demo screen',
              subtitle: 'A demo of the widget that selects multiple dates.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomDemoScreen(),
                ),
              ),
            ),
            _buildListTile(
              title: 'Event demo screen',
              subtitle: 'A demo of the widget that event dates.',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventDemoScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
