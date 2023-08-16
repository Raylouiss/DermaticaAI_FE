import 'dart:ui';

import 'package:flutter/material.dart';

class ScannerDesc extends StatefulWidget {
  const ScannerDesc({super.key});

  @override
  State<ScannerDesc> createState() => _ScannerDescState();
}

class _ScannerDescState extends State<ScannerDesc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5F93A0),
        title: Text(
          'Scanner',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Dermatitis (Eksem)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 10,),
            Image.asset('assets/logo_kelompok.png'),
            SizedBox(height: 10,),
            Text("Eksem atau sering disebut eksema, atau dermatitis adalah peradangan hebat yang menyebabkan pembentukan lepuh atau gelembung kecil (vesikel) pada kulit hingga akhirnya pecah dan mengeluarkan cairan. Istilah eksem juga digunakan untuk sekelompok kondisi yang menyebabkan perubahan pola pada kulit dan menimbulkan perubahan spesifik di bagian permukaan. Istilah ini diambil dari yang berarti 'mendidih atau mengalir keluar'.",
            textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Gejala',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ),
            Text(
            'Eksem ringan: daerah halus, sedikit memerah kering, bersisik, dapat menimbulkan gatal ataupun tidak, dan biasanya terdapat pada kaki atau lengan.\n\n'
                'Eksem akut: kulit akan mengalami gatal yang intens, biasanya terjadi di bagian depan siku, belakang lutut, dan wajah. Namun, setiap daerah kulit mungkin terpengaruh. Selanjutnya, kulit menjadi lebih sensitif terhadap kain gatal, terutama wol. Pada musim dingin, eksem akan menjadi makin parah karena udara di dalam ruangan sangat kering.',
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Faktor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
            ),
            Text(
              'Eksem ringan: daerah halus, sedikit memerah kering, bersisik, dapat menimbulkan gatal ataupun tidak, dan biasanya terdapat pada kaki atau lengan.\n\n'
                  'Eksem akut: kulit akan mengalami gatal yang intens, biasanya terjadi di bagian depan siku, belakang lutut, dan wajah. Namun, setiap daerah kulit mungkin terpengaruh. Selanjutnya, kulit menjadi lebih sensitif terhadap kain gatal, terutama wol. Pada musim dingin, eksem akan menjadi makin parah karena udara di dalam ruangan sangat kering.',
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Pengobatan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
            ),
            Text(
              'Eksem ringan: daerah halus, sedikit memerah kering, bersisik, dapat menimbulkan gatal ataupun tidak, dan biasanya terdapat pada kaki atau lengan.\n\n'
                  'Eksem akut: kulit akan mengalami gatal yang intens, biasanya terjadi di bagian depan siku, belakang lutut, dan wajah. Namun, setiap daerah kulit mungkin terpengaruh. Selanjutnya, kulit menjadi lebih sensitif terhadap kain gatal, terutama wol. Pada musim dingin, eksem akan menjadi makin parah karena udara di dalam ruangan sangat kering.',
            ),
          ],
        ),
      ),
    );
  }
}
