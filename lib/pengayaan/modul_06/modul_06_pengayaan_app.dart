import 'package:flutter/material.dart';
import '../../modul_06/services/auth_api.dart';
import '../../modul_06/services/sesi_memori.dart';
import 'controllers/sesi_controller.dart';
import 'repositories/aman_sesi_repository.dart';
import 'repositories/memori_sesi_repository.dart';
import 'repositories/prefs_sesi_repository.dart';
import 'repositories/sesi_repository.dart';
import 'screens/beranda_pengayaan_screen.dart';
import 'screens/login_pengayaan_screen.dart';
import 'storage/penyimpanan_aman_platform.dart';
import 'widgets/gerbang_sesi.dart';

class Modul06PengayaanApp extends StatefulWidget {
  const Modul06PengayaanApp({super.key});

  @override
  State<Modul06PengayaanApp> createState() => _Modul06PengayaanAppState();
}

class _Modul06PengayaanAppState extends State<Modul06PengayaanApp> {
  late final List<SesiRepository> _repositories;
  late final SesiController _kendali;
  int _indeksAktif = 0;

  @override
  void initState() {
    super.initState();
    _repositories = <SesiRepository>[
      MemoriSesiRepository(SesiMemori()),
      PrefsSesiRepository(),
      AmanSesiRepository(PenyimpananAmanPlatform()),
    ];

    _kendali = SesiController(
      repository: _repositories[_indeksAktif],
      api: const AuthApi(),
    );

    _kendali.pulihkan();
  }

  @override
  void dispose() {
    _kendali.dispose();
    super.dispose();
  }

  void _gantiPenyimpanan(int? indeks) {
    if (indeks == null || indeks == _indeksAktif) return;
    setState(() {
      _indeksAktif = indeks;
    });
    _kendali.ubahRepository(_repositories[indeks]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 06 — Pengayaan Sesi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: <Widget>[
                    const Text(
                      'Penyimpanan: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: DropdownButton<int>(
                        value: _indeksAktif,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: List<DropdownMenuItem<int>>.generate(
                          _repositories.length,
                          (int i) => DropdownMenuItem<int>(
                            value: i,
                            child: Text(_repositories[i].nama),
                          ),
                        ),
                        onChanged: _gantiPenyimpanan,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GerbangSesi(
                controller: _kendali,
                form: (BuildContext context) =>
                    LoginPengayaanScreen(controller: _kendali),
                beranda: (BuildContext context, sesi) => BerandaPengayaanScreen(
                  controller: _kendali,
                  sesi: sesi,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}