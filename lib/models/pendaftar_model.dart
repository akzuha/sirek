import 'package:cloud_firestore/cloud_firestore.dart';

class PendaftarModel {
  PendaftarModel({
    required this.id,
    required this.namaEvent,
    required this.namaPendaftar,
    required this.emailPendaftar,
    required this.telepon,
    required this.alamat,
    required this.tglLahir,
    required this.jenisKelamin,
    required this.nim,
    required this.jurusan,
    required this.fakultas,
    required this.angkatan,
    required this.pilihanSatu,
    required this.pilihanDua,
    required this.alasan,
    required this.fileCV,
    required this.fileLOC,
  });

  factory PendaftarModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PendaftarModel(
      id: doc.id,
      namaEvent: data['namaEvent'],
      namaPendaftar: data['namaPendaftar'],
      emailPendaftar: data['emailPendaftar'],
      telepon: data['telepon'],
      alamat: data['alamat'],
      tglLahir: (data['tglLahir'] as Timestamp).toDate(),
      jenisKelamin: data['jenisKelamin'],
      nim: data['nim'],
      jurusan: data['jurusan'],
      fakultas: data['fakultas'],
      angkatan: data['angkatan'],
      pilihanSatu: data['pilihanSatu'],
      pilihanDua: data['pilihanDua'],
      alasan: data['alasan'],
      fileCV: data['fileCV'],
      fileLOC: data['fileLOC'],
    );
  }

  String alamat;
  String alasan;
  int angkatan;
  String emailPendaftar;
  String fakultas;
  String fileCV;
  String fileLOC;
  String id;
  String jenisKelamin;
  String jurusan;
  String namaEvent;
  String namaPendaftar;
  String nim;
  String pilihanDua;
  String pilihanSatu;
  int telepon;
  DateTime tglLahir;

  // Convert EventModel to Map (useful for Firestore operations)
  Map<String, dynamic> toMap() {
    return {
      'namaEvent': namaEvent,
      'namaPendaftar': namaPendaftar,
      'emailPendaftar': emailPendaftar,
      'telepon': telepon,
      'alamat': alamat,
      'tglLahir': tglLahir,
      'jenisKelamin': jenisKelamin,
      'nim': nim,
      'jurusan': jurusan,
      'fakultas': fakultas,
      'angkatan': angkatan,
      'pilihanSatu': pilihanSatu,
      'pilihanDua': pilihanDua,
      'alasan': alasan,
      'fileCV': fileCV,
      'fileLOC': fileLOC,
    };
  }
}

// model/event_model.dart
class PendaftarRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all events
  Future<List<PendaftarModel>> fetchAllPendaftars() async {
    QuerySnapshot snapshot = await _firestore.collection('pendaftar').get();
    return snapshot.docs
        .map((doc) => PendaftarModel.fromDocument(doc))
        .toList();
  }

  // Create a new event
  Future<void> createPendaftar(PendaftarModel pendaftar) async {
    await _firestore.collection('pendaftar').add(pendaftar.toMap());
  }

  // Update an event
  Future<void> updatePendaftar(String id, PendaftarModel pendaftar) async {
    await _firestore.collection('pendaftar').doc(id).update(pendaftar.toMap());
  }

  // Delete an event
  Future<void> deletePendaftar(String id) async {
    await _firestore.collection('pendaftar').doc(id).delete();
  }
}

  //  Future<void> createPendaftar(PendaftarModel pendaftar,  File? cvFile, File? locFile) async {
  //   try {
  //     String? FileLOC;
  //     String? FileCV;

  //     if (locFile != null) {
  //       FileLOC = await uploadFile(locFile, 'pendaftar/file LOC');
  //     }

  //     if (cvFile != null) {
  //       FileCV = await uploadFile(cvFile, 'pendaftar/file CV');
  //     }

  //     final updatedEvent = PendaftarModel(
  //       id: pendaftar.id,
  //       namaEvent: pendaftar.namaEvent,
  //       namaPendaftar: pendaftar.namaPendaftar, 
  //       emailPendaftar: pendaftar.emailPendaftar, 
  //       telepon: pendaftar.telepon, 
  //       alamat: pendaftar.alamat, 
  //       tglLahir: pendaftar.tglLahir, 
  //       jenisKelamin: pendaftar.jenisKelamin, 
  //       nim: pendaftar.nim, 
  //       jurusan: pendaftar.jurusan, 
  //       fakultas: pendaftar.fakultas, 
  //       angkatan: pendaftar.angkatan,
  //       pilihanSatu: pendaftar.pilihanSatu, 
  //       pilihanDua: pendaftar.pilihanDua, 
  //       alasan: pendaftar.alasan, 
  //       fileCV: FileCV ?? '', 
  //       fileLOC: FileLOC ?? '',
  //     );

  //     await _firestore.collection('event').add(updatedEvent.toMap());
  //   } catch (e) {
  //     throw Exception('Failed to create event: $e');
  //   }
  // }
