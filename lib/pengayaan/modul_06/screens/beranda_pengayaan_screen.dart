import 'package:flutter/material.dart';
import '../../../modul_06/models/sesi_pengguna.dart';
import '../../../modul_06/widgets/kartu_sesi.dart';
import '../controllers/sesi_controller.dart';
import '../widgets/papan_diagnostik_penyimpanan.dart';

class BerandaPengayaanScreen extends StatelessWidget {
  final SesiController controller;
  final SesiPengguna sesi;

  const BerandaPengayaanScreen({
    super.key,
    required this.controller,
    required this.sesi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Pengayaan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          KartuSesi(
            sesi: sesi,
            sekarang: controller.jam(),
            onKeluar: () => controller.keluar(),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => controller.perbaruiSesi(),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Perbarui Sesi (Refresh)'),
          ),
          const SizedBox(height: 24),
          PapanDiagnostikPenyimpanan(repository: controller.repository),
        ],
      ),
    );
  }
}