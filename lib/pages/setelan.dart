import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ubah_data_diri.dart';

class SetelanPage extends StatelessWidget {
  const SetelanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepOrange, Colors.deepOrange.shade300],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Pengaturan'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.deepOrange),
                      title: const Text('Ubah Data Diri'),
                      subtitle: const Text('Ubah nama dan NIM'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UbahDataDiriScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.info, color: Colors.deepOrange),
                      title: const Text('Tentang Aplikasi'),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Jurusan Inggris App',
                          applicationVersion: '1.0.0',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}