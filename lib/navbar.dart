import 'package:flutter/material.dart';

// import 'package:my_project/login_screen.dart';
// import 'package:my_project/profile.dart';
import 'package:my_project/search_screen.dart';
// import 'package:share_plus/share_plus.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    //Drawer is a scafolds side menu bar for
    return Drawer(
        //showing lists of Listtile widgets
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        //DrawerHeader is a widget that displays a header of the drawer
        const UserAccountsDrawerHeader(
          accountName: Text(
            'Logged In as:',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 16),
          ),
          accountEmail: Text(
            "someone@gmail.com",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 18),
          ),
          currentAccountPicture: CircleAvatar(
            maxRadius: 30,
            minRadius: 30,
            backgroundImage: AssetImage("images/man.png"),
          ),
          decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage("images/bkg.jpg"),
                fit: BoxFit.cover,
              )),
        ),
        // ListTitle is a list view that shows predefined details wraped within a container
        //showing search page
        ListTile(
          // Leading is the icon/images part to show at the begining
          leading: const Icon(
            Icons.search,
            size: 30,
          ),
          //Title is the text part to show at the begining
          title: const Text(
            'Search',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 22),
          ),
          onTap: () {
            // pop closes the drawer
            Navigator.pop(context);
          },
          // show the widget after the title
          trailing: const Icon(Icons.arrow_forward, size: 25),
          // ignore: avoid_returning_null_for_void
        ),
        ListTile(
          leading: const Icon(Icons.person, size: 30),
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (BuildContext context) {
            //     return const Profile();
            //   },
            // ));
          },
          title: const Text(
            'Profile',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 22),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.login, size: 30),
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (BuildContext context) {
            //   return const Login();
            // }));
          },
          title: const Text(
            'Login',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 22),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app, size: 30),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const Search();
            }));
          },
          title: const Text(
            'Exit',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 22),
          ),
        ),
      ],
    ));
  }
}
