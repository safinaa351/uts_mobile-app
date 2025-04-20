import 'package:flutter/material.dart';

class AkreditasiPage extends StatelessWidget {
  const AkreditasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAkreditasiItem(
                  context,
                  'D3 Bahasa Inggris',
                  'B',
                  'assets/images/sertif_D3.png',
                ),
                const SizedBox(height: 16),
                _buildAkreditasiItem(
                  context,
                  'D4 Bahasa Inggris untuk Komunikasi Bisnis dan Profesional',
                  'BAIK',
                  'assets/images/sertif_D4.png',
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
          'Akreditasi',
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

  Widget _buildAkreditasiItem(
    BuildContext context,
    String programName,
    String grade,
    String certificateImagePath,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  programName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => _showCertificateDialog(context, certificateImagePath),
                  child: const Text(
                    'Lihat sertifikat',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                grade,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCertificateDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _CertificateViewerDialog(imagePath: imagePath);
      },
    );
  }
}

class _CertificateViewerDialog extends StatefulWidget {
  final String imagePath;

  const _CertificateViewerDialog({Key? key, required this.imagePath}) : super(key: key);

  @override
  _CertificateViewerDialogState createState() => _CertificateViewerDialogState();
}

class _CertificateViewerDialogState extends State<_CertificateViewerDialog> {
  double _scale = 1.0;
  final double _minScale = 0.5;
  final double _maxScale = 3.0;
  Offset _position = Offset.zero;
  late TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _updateScale(double scaleFactor) {
    setState(() {
      final double newScale = _scale * scaleFactor;
      if (newScale >= _minScale && newScale <= _maxScale) {
        _scale = newScale;
        
        // Update the transformation matrix
        final Matrix4 matrix = Matrix4.identity()
          ..translate(_position.dx, _position.dy)
          ..scale(_scale);
        _transformationController.value = matrix;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: GestureDetector(
          onTap: () {}, // Prevent closing when tapping on the image
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: _minScale,
                    maxScale: _maxScale,
                    onInteractionEnd: (details) {
                      _position = Offset(
                        _transformationController.value.getTranslation().x,
                        _transformationController.value.getTranslation().y,
                      );
                      _scale = _transformationController.value.getMaxScaleOnAxis();
                    },
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, size: 50),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.white),
                      onPressed: () => _updateScale(0.8),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.white),
                      onPressed: () => _updateScale(1.25),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}