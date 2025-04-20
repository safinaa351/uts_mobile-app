import 'package:flutter/material.dart';
import 'package:jurusan_inggris/pages/dashboard.dart';
import 'package:jurusan_inggris/pages/kalender.dart';
import 'package:jurusan_inggris/widgets/bottom_navbar.dart';
import 'package:jurusan_inggris/pages/profil_jurusan.dart';
import 'package:jurusan_inggris/pages/program_studi.dart';
import 'package:jurusan_inggris/pages/akreditasi.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  int _selectedFeatureIndex = -1; // Diubah ke -1 agar dashboard ditampilkan saat awal
  bool _isDrawerVisible = false;

  // Navigasi bottom bar utama (global navigation)
  final List<Widget> _mainPages = [];
  
  // Fitur khusus dari dashboard (feature navigation)
  final List<Widget> _featurePages = [];
  
  @override
  void initState() {
    super.initState();
    
    // Menu utama di bottom navbar
    _mainPages.addAll([
      DashboardPage(onNavigate: _navigateToFeature), // Dashboard dengan fungsi navigasi ke fitur
      const Center(child: Text("Pencarian (coming soon)")),
      const Center(child: Text("Pengaturan (coming soon)")),
    ]);
    
    // Halaman fitur utama (yang diakses dari dashboard)
    _featurePages.addAll([
      const KalenderPage(),
      const ProfilJurusanPage(),
      const ProgramStudiPage(),
      const AkreditasiPage(),
    ]);
  }

  // Fungsi untuk navigasi antara menu utama (bottom navbar)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Reset feature index ketika kembali ke menu utama
      _selectedFeatureIndex = -1;
    });
  }
  
  // Fungsi untuk navigasi ke fitur utama
  void _navigateToFeature(int featureIndex) {
    setState(() {
      _selectedFeatureIndex = featureIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan widget yang akan ditampilkan
    Widget currentPage;
    
    // Jika ada fitur yang dipilih dan sedang di dashboard, tampilkan fitur
    if (_selectedIndex == 0 && _selectedFeatureIndex >= 0) {
      currentPage = _featurePages[_selectedFeatureIndex];
    } else {
      // Jika tidak, tampilkan halaman utama sesuai bottom navbar
      currentPage = _mainPages[_selectedIndex];
    }
    
    return Scaffold(
      body: Stack(
        children: [
          // Konten utama
          currentPage,
          
          // Gesture detector untuk drawer
          GestureDetector(
            onHorizontalDragEnd: (details) {
              // Swipe right untuk menampilkan floating navbar
              if (details.primaryVelocity! > 0) {
                setState(() {
                  _isDrawerVisible = true;
                });
              }
            },
          ),
          
          // Floating Navbar (Feature Navigation)
          if (_isDrawerVisible)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isDrawerVisible = false;
                  });
                },
                onHorizontalDragEnd: (details) {
                  // Swipe left untuk menyembunyikan floating navbar
                  if (details.primaryVelocity! < 0) {
                    setState(() {
                      _isDrawerVisible = false;
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFloatingNavItem(
                        icon: Icons.calendar_today,
                        label: 'Kalender',
                        onTap: () {
                          _navigateToFeature(0);
                          setState(() {
                            _isDrawerVisible = false;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildFloatingNavItem(
                        icon: Icons.account_balance,
                        label: 'Profil',
                        onTap: () {
                          _navigateToFeature(1);
                          setState(() {
                            _isDrawerVisible = false;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildFloatingNavItem(
                        icon: Icons.book,
                        label: 'Prodi',
                        onTap: () {
                          _navigateToFeature(2);
                          setState(() {
                            _isDrawerVisible = false;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildFloatingNavItem(
                        icon: Icons.verified,
                        label: 'Akreditasi',
                        onTap: () {
                          _navigateToFeature(3);
                          setState(() {
                            _isDrawerVisible = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildFloatingNavItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}