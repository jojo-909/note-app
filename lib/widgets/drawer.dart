import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'NOTELY',
                style: TextStyle(
                    fontFamily: 'TitanOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                child: Image.asset(
                  'assets/images/Mask Group 1.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                '${user.username}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(64, 59, 54, 1),
                    fontSize: 24)
              ),
              Text(
                'Lagos, Nigeria',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(89, 85, 80, 1),
                  fontSize: 16),
                )
            ]),
          ),
          SizedBox(height: 10,),
          Divider(
            height: 2,
            indent: 0,
            endIndent: 0,
            color: Color.fromRGBO(89, 85, 80, 1),
          ),
          ListTile(
            leading: Image.asset('assets/images/Frame 44.png'),
            title: Text('Buy Premium'),
            trailing: Image.asset('assets/images/Arrow left 1.png'),
          ),
          ListTile(
            leading: Image.asset('assets/images/Frame 45.png'),
            title: Text('Edit Profile'),
            trailing: Image.asset('assets/images/Arrow left 1.png'),
          ),
          ListTile(
            leading: Image.asset('assets/images/Frame 46.png'),
            title: Text('App Theme'),
            trailing: Image.asset('assets/images/Arrow left 1.png'),
          ),
          ListTile(
            leading: Image.asset('assets/images/Frame 47.png'),
            title: Text('Notifications'),
            trailing: Image.asset('assets/images/Arrow left 1.png'),
          ),
          ListTile(
            leading: Image.asset('assets/images/Frame 48.png'),
            title: Text('Security'),
            trailing: Image.asset('assets/images/Arrow left 1.png'),
          ),
          GestureDetector(
            onTap: () => Provider.of<Auth>(context, listen: false).logout(),
            child: ListTile(
              leading: Image.asset('assets/images/Frame 49.png'),
              title: Text('Log Out'),
              trailing: Image.asset('assets/images/Arrow left 1.png'),
            ),
          )
        ],
      ),
    );
  }
}
