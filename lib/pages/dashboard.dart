import 'package:flutter/material.dart';
import 'package:jurusan_inggris/pages/kalender.dart';
import 'package:jurusan_inggris/widgets/bottom_navbar.dart';
import 'package:jurusan_inggris/pages/profil_jurusan.dart';

class DashboardPage extends StatelessWidget {
  final Function(int) onNavigate;
  const DashboardPage({Key? key, required this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildMainFeatures(),
                      const SizedBox(height: 16),
                      _buildNewsSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() { //THIS TOP PART THAT CONTAINS THE IMAGE, NAME, NIM, AND NOTIFICATION ICON
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/gedungPNP.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      height: 170,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/foto_profil.jpeg'),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Jonathan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '5190411016',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildMainFeatures() { //this part builds the box with 4 circle icons and labels
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menu',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFeatureItem(
                icon: Icons.calendar_today,
                label: 'Kalender',
                color: Colors.deepOrange,
                index: 1,
              ),
              _buildFeatureItem(
                icon: Icons.account_balance,
                label: 'Profil Jurusan',
                color: Colors.deepOrange,
                index: 2,
              ),
              _buildFeatureItem(
                icon: Icons.book,
                label: 'Program Studi',
                color: Colors.deepOrange,
              ),
              _buildFeatureItem(
                icon: Icons.verified,
                label: 'Akreditasi',
                color: Colors.deepOrange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem({ //this part builds the circle icon with label
    required IconData icon,
    required String label,
    required Color color,
    int? index,
  }) {
        return GestureDetector(
          onTap: () {
            if (index != null) {
              onNavigate(index); // gunakan callback untuk navigasi antar tab
            }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      }

  Widget _buildNewsSection() { //this shows the news title and news card with headline + img
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Berita Seputar Jurusan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
        const SizedBox(height: 16),
        _buildNewsItem(
          title: 'Keseruan Kelas 3A D4 KBP Praktik Hospitality di Alahan Panjang',
          imageUrl: 'assets/images/berita_front.jpeg',
        ),
      ],
    );
  }

  Widget _buildNewsItem({required String title, required String imageUrl}) { //this builds the rectangle card
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $error');
                return Container(
                  width: double.infinity,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
