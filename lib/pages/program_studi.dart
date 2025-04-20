import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgramStudiPage extends StatelessWidget {
  const ProgramStudiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildProgramStudiSection(
                  context,
                  'D3 Bahasa Inggris',
                  'assets/images/logo_poltek.png',
                  isD3: true,
                ),
                const SizedBox(height: 16),
                _buildProgramStudiSection(
                  context,
                  'D4 Bahasa Inggris untuk Komunikasi Bisnis dan Profesional',
                  'assets/images/logo_poltek.png',
                  isD3: false,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.deepOrange,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Center(
        child: Text(
          'Program Studi',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProgramStudiSection(
    BuildContext context,
    String title,
    String imagePath, {
    required bool isD3,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 160,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
          
          // Title section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Button section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: GestureDetector(
              onTap: () => isD3 ? _showD3Dialog(context) : _showD4Dialog(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Selanjutnya',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showD3Dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'D3 Bahasa Inggris',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 16),
                const Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      'Perkuliahan perdana di Jurusan D-III Bahasa Inggris dimulai pada semester ganjil tahun 2009/2010 dengan jumlah mahasiswa sebanyak 22 orang. Saat itu, Jurusan  D-III Bahasa Inggris hanya memiliki sarana penunjang akademik seperti Labor Bahasa dan Labor Komputer yang dipakai bersama dengan Prodi lain. Fasilitas penunjang akademik ini terus ditingkatkan, hingga akhirnya saat ini Jurusan D-III Bahasa Inggris telah memiliki ruangan Student Access Center (SAC) yang juga berfungsi sebagai pustaka mini, labor translation, labor bahasa, ruang konsultasi mahasiswa dan juga studio Radio dan TV. Selain itu, Jurusan D-III Bahasa Inggris menawarkan perkuliahan selama 3 tahun (6 semester) di bidang Bahasa Inggris dengan kompetensi utama di bidang Bahasa Inggris serta kompetensi khusus di bidang translation (penerjemahan) dan broadcasting (radio dan TV). Selama pendidikan, peserta didik dibekali ilmu baik berupa teori maupun keterampilan yang berguna khususnya untuk memasuki dunia kerja.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _launchURL('https://bing.pnp.ac.id/program-studi/prodi-d3-bahasa-inggris/kurikulum-d3bing/'),
                  child: const Text(
                    'Lihat kurikulum',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showD4Dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'D4 Bahasa Inggris untuk Komunikasi Bisnis dan Profesional',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 16),
                const Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      'Prodi D-IV Bahasa Inggris untuk Komunikasi Bisnis dan Profesional ini merupakan kesatuan rencana belajar yang mengkaji, menerapkan, dan mengembangkan ilmu dalam penerjemahan di bidang bisnis, Wirausaha di bidang Bahasa Inggris, Jurnalis media berbahasa Inggris, Penulis Bahasa Inggris di Industri kreatif (Content writer, Copy writer, Content editor), dan kemampuan dalam Public Relation dan Customer Service Officer (Instrumen Pemenuhan Syarat Minimum Akreditasi Program Studi. program Diploma III & Diploma IV (Sarjana Terapan), 2019).',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _launchURL('https://bing.pnp.ac.id/program-studi/d4-bahasa-inggris-untuk-komunikasi-bisnis-dan-profesional/kurikulum-d4-bahasa-inggris-untuk-komunikasi-bisnis-dan-profesional/'),
                  child: const Text(
                    'Lihat kurikulum',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}