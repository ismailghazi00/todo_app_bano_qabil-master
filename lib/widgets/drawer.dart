import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          //prebuilt dart funcation
          decoration: const BoxDecoration(color: Color(0xff8687E7)),
          child: Row(
            children: [
              CircleAvatar(
                  //prebuilt dart funcation to display Images in round shape
                  backgroundColor: Theme.of(context).colorScheme.background,
                  radius: 30,
                  foregroundImage:
                      const AssetImage('assets/profilepicure.jpg')),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ismail Ghazi',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'ismailghazi@gmail.com',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
        ListTile(
          //a prebuilt List Tile with Title, sub title, pic/logo (Landing) and On Tap to add funcation on it if you want
          onTap: () {},
          title: Text(
            "Profile",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Text(
            "view your profile",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          leading: const Icon(Icons.person),
        ),
        ListTile(
          onTap: () {},
          title: Text(
            "Log out",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text("Log out form profile",
              style: Theme.of(context).textTheme.bodySmall),
          leading: const Icon(Icons.logout),
        ),
        ListTile(
            onTap: () {},
            title: Text(
              "Change Color Theme",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text("Click Change to Normal Theme",
                style: Theme.of(context).textTheme.bodySmall),
            leading: const Icon(Icons.app_shortcut_outlined))
      ],
    );
  }
}
