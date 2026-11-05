import 'package:flutter/material.dart';
import '../../../modul_06/services/auth_api.dart';
import '../../../modul_06/widgets/field_kata_sandi.dart';
import '../controllers/sesi_controller.dart';
import '../widgets/papan_diagnostik_penyimpanan.dart';

class LoginPengayaanScreen extends StatefulWidget {
  final SesiController controller;

  const LoginPengayaanScreen({
    super.key,
    required this.controller,
  });

  @override
  State<LoginPengayaanScreen> createState() => _LoginPengayaanScreenState();
}

class _LoginPengayaanScreenState extends State<LoginPengayaanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _sandi = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _sandi.dispose();
    super.dispose();
  }

  void _kirim() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.controller.masuk(_email.text, _sandi.text);
  }

  @override
  Widget build(BuildContext context) {
    final bool sibuk = widget.controller.status == StatusSesi.memproses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modul 06 — Login (Pengayaan)'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          if (widget.controller.pesan != null) ...<Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.controller.pesan!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _email,
                  enabled: !sibuk,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? val) {
                    if (val == null || val.isEmpty) return 'Email wajib diisi.';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FieldKataSandi(
                  controller: _sandi,
                  enabled: !sibuk,
                  validator: (String? val) {
                    if (val == null || val.isEmpty) return 'Kata sandi wajib diisi.';
                    return null;
                  },
                  onSubmitted: _kirim,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: sibuk ? null : _kirim,
            child: Text(sibuk ? 'Memproses...' : 'Masuk'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: sibuk
                ? null
                : () {
                    _email.text = AuthApi.emailDemo;
                    _sandi.text = AuthApi.sandiDemo;
                  },
            child: const Text('Isi Kredensial Demo'),
          ),
          const SizedBox(height: 24),
          PapanDiagnostikPenyimpanan(repository: widget.controller.repository),
        ],
      ),
    );
  }
}