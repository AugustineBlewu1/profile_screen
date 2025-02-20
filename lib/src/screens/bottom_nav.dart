// ignore_for_file: deprecated_member_use

import '../utils/export.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> screens = [HomePage(), RequestScreen(), ProfileScreen()];
  int currentItem = 0;
  onTap(int currentIndex) {
    setState(() {
      currentItem = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentItem,
        onTap: onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/home.svg",
                color: neutral,
              ),
              label: 'Home',
              activeIcon: SvgPicture.asset(
                "assets/svg/home.svg",
                color: primarColor,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/service.svg",
                color: neutral,
              ),
              label: 'Requests',
              activeIcon: SvgPicture.asset("assets/svg/service.svg")),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
      body: Center(
        child: screens.elementAt(currentItem),
      ),
    );
  }
}
