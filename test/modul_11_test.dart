import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mo06/modul_11/modul_11_app.dart';

void main() {
  testWidgets('Filter mata kuliah mengubah jumlah hasil yang ditampilkan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const Modul11App());
    await tester.pumpAndSettle();

    // Pastikan kondisi awal menampilkan 1000 dari 1000 tugas
    expect(find.text('Menampilkan 1000 dari 1000 tugas'), findsOneWidget);

    // Cari dropdown filter mata kuliah dan ketuk untuk membuka pilihan
    final dropdownFinder = find.byKey(const ValueKey('course-filter-dropdown'));
    expect(dropdownFinder, findsOneWidget);
    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle();

    // Pilih opsi "Pemrograman Mobile" (ada 125 tugas dari 1000 data / 8 matkul)
    final opsiMatkul = find.text('Pemrograman Mobile').last;
    await tester.tap(opsiMatkul);
    await tester.pumpAndSettle();

    // Pembuktian: Jumlah hasil berubah menjadi 125 dari 1000 tugas
    expect(find.text('Menampilkan 125 dari 1000 tugas'), findsOneWidget);
  });
}