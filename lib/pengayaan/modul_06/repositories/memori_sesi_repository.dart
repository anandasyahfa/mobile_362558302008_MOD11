import '../../../modul_06/models/sesi_pengguna.dart';
import '../../../modul_06/services/sesi_memori.dart';
import 'sesi_repository.dart';

class MemoriSesiRepository implements SesiRepository {
  final SesiMemori _sesiMemori;

  MemoriSesiRepository(this._sesiMemori);

  @override
  String get nama => 'Memori Proses';

  @override
  String get keterangan => 'Sesi hilang saat aplikasi ditutup/direstart.';

  @override
  bool get bertahanSetelahRestart => false;

  @override
  Future<SesiPengguna?> baca() async => _sesiMemori.baca();

  @override
  Future<void> simpan(SesiPengguna sesi) async => await _sesiMemori.simpan(sesi);

  @override
  Future<void> hapus() async => await _sesiMemori.hapus();

  @override
  Future<bool> adaSesi() async => _sesiMemori.adaSesi;

  @override
  Future<String?> intipMentah() async => null;
}