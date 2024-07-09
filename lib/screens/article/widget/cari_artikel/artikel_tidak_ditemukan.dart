import 'package:flutter/material.dart';

class ArtikelTidakDitemukanWidget extends StatelessWidget {
  const ArtikelTidakDitemukanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 203,
        height: 169.88,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 129.88,
              width: 200,
              child: Image.asset(
                'assets/images/NoLocationFound.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Oops, Artikel Tidak Ditemukan')
          ],
        ),
      ),
    );
  }
}
