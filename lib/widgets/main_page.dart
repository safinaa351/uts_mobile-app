import 'package:flutter/material.dart';
import 'package:jurusan_inggris/pages/dashboard.dart';
import 'package:jurusan_inggris/pages/kalender.dart';
import 'package:jurusan_inggris/widgets/bottom_navbar.dart';
import 'package:jurusan_inggris/pages/profil_jurusan.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages.addAll([
      DashboardPage(onNavigate: _onItemTapped), // 👈 kirim fungsi navigasi
      const KalenderPage(),
      const ProfilJurusanPage(),
      const Center(child: Text("Settings Page (coming soon)")),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
