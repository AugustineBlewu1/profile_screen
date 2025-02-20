

import '../utils/export.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  //const trailing icon
  final Icon trailingIcon = Icon(Icons.arrow_forward_ios_sharp, color: neutral,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Account",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: gray,
                child: Text(
                  "JL",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Jonathan Mensah",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: neutralStronger),
            ),
            Text(
              "0244123456",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w400, color: neutralStrong),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    ListItem(
                      svgAsset: 'profile.svg',
                      name: "Update Profile",
                      trailing: trailingIcon,
                      onTap: () {
                        //naviagate to profile update screen
                        context.push(UpdateProfile());
                      },
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    ListItem(
                      svgAsset: 'service.svg',
                      name: "Service Preference",
                      trailing:trailingIcon
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    ListItem(
                      svgAsset: 'availability.svg',
                      name: "Availability",
                      trailing: trailingIcon,
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    ListItem(
                      svgAsset: 'notifications.svg',
                      name: "Manage Notifications",
                      trailing: trailingIcon,
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    ListItem(
                      svgAsset: 'support.svg',
                      name: "Support",
                      trailing: trailingIcon,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    ListItem(
                      svgAsset: 'lock.svg',
                      name: "Change Password",
                      trailing: trailingIcon,
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    ListItem(
                      svgAsset: 'cancellation.svg',
                      name: "Request account deletion",
                      trailing: trailingIcon,
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    ListItem(
                      svgAsset: 'logout.svg',
                      name: "Logout",
                      isLogout: true,
                      trailing: Text(""),
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    ListItem(
                      svgAsset: 'version.svg',
                      name: "App version",
                      trailing: Text(
                        "1.0.0",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                   
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
