import 'package:final_app/pages/history.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blueGrey.shade800,
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'History',
                    icon: Icons.history,
                    onClicked: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HistoryPage(),
                      )),
                      ), 
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Memory',
                    icon: Icons.memory,
                    onClicked: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HistoryPage(),
                     )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildMenuItem({
    String ?text,
    IconData ?icon,
    VoidCallback ?onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text!, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}