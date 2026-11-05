import 'dart:convert';
import '../../../modul_06/models/sesi_pengguna.dart';
import '../storage/penyimpanan_aman.dart';
import 'sesi_repository.dart';

class AmanSesiRepository implements SesiRepository {
  static const String kunciSesi = 'sesi_pengguna_aman';
  final PenyimpananAman penyimpanan;

  AmanSesiRepository(this.penyimpanan);

  @override
  String get nama => 'Secure Storage';

  @override
  String get keterangan =>
      'Bertahan dan tersimpan terenkripsi menggunakan Keychain/Keystore.';

  @override
  bool get bertahanSetelahRestart => true;

  @override
  Future<SesiPengguna?> baca() async {
    final String? jsonString = await penyimpanan.baca(kunciSesi);
    if (jsonString == null || jsonString.isEmpty) return null;

    try {
      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      return SesiPengguna.fromJson(jsonMap);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> simpan(SesiPengguna sesi) async {
    final String jsonString = jsonEncode(sesi.toJson());
    await penyimpanan.tulis(kunciSesi, jsonString);
  }

  @override
  Future<void> hapus() async {
    await penyimpanan.hapus(kunciSesi);
  }

  @override
  Future<bool> adaSesi() async {
    final String? nilai = await penyimpanan.baca(kunciSesi);
    return nilai != null;
  }

  @override
  Future<String?> intipMentah() => penyimpanan.bacaMentah(kunciSesi);
}