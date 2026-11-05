import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'services/auth_api.dart';
import 'services/sesi_memori.dart';

class Modul06App extends StatefulWidget {
  final AuthApi? api;
  final SesiMemori? sesiMemori;

  /// `--dart-define=LAMBAT=true` 
  static const bool lambatSimulasi = bool.fromEnvironment('LAMBAT');

  const Modul06App({super.key, this.api, this.sesiMemori});

  @override
  State<Modul06App> createState() => _Modul06AppState();
}

class _Modul06AppState extends State<Modul06App> {
  late final SesiMemori _sesiMemori = widget.sesiMemori ?? SesiMemori();

  late final AuthApi _api = widget.api ??
      (Modul06App.lambatSimulasi
          ? const AuthApi(tunda: Duration(seconds: 2))
          : const AuthApi());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 06 — Login & Session Dasar',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: LoginScreen(api: _api, sesiMemori: _sesiMemori),
    );
  }
}
