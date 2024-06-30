import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SideBarScreens extends StatelessWidget {
  const SideBarScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 255, 245, 221),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: UserAccountsDrawerHeader(
              accountName: const Text(
                'Wawan Hermawan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(
                '2106144@itg.ac.id',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'images/user.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.TJReqvp5iaRmLCEH2hC3MQHaEo?w=284&h=180&c=7&r=0&o=5&pid=1.7'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                "Home",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              }),
          ListTile(
              leading: const Icon(Icons.cookie),
              title: const Text(
                "Product",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/product');
              }),
          ListTile(
              leading: const Icon(Icons.storage),
              title: const Text(
                "Stock",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/stock');
              }),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                "Reseler",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/reseler');
              }),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                "About",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              }),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              "Keluar",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Keluar Aplikasi"),
                    content: const Text("Apakah Anda yakin ingin keluar?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Tidak"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Ya"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            SystemNavigator.pop();
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
