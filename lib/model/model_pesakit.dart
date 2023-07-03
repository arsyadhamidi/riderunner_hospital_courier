// To parse this JSON data, do
//
//     final modelPesakit = modelPesakitFromJson(jsonString);

import 'dart:convert';

ModelPesakit modelPesakitFromJson(String str) => ModelPesakit.fromJson(json.decode(str));

String modelPesakitToJson(ModelPesakit data) => json.encode(data.toJson());

class ModelPesakit {
  bool? success;
  List<DataPesakit>? data;
  String? message;
  int? price;

  ModelPesakit({
    this.success,
    this.data,
    this.message,
    this.price,
  });

  factory ModelPesakit.fromJson(Map<String, dynamic> json) => ModelPesakit(
    success: json["success"],
    data: json["data"] == null ? [] : List<DataPesakit>.from(json["data"]!.map((x) => DataPesakit.fromJson(x))),
    message: json["message"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "price": price,
  };
}

class DataPesakit {
  Pesakit? pesakit;
  List<Obat>? obats;
  dynamic branches;
  int? totalHarga;

  DataPesakit({
    this.pesakit,
    this.obats,
    this.branches,
    this.totalHarga,
  });

  factory DataPesakit.fromJson(Map<String, dynamic> json) => DataPesakit(
    pesakit: json["pesakit"] == null ? null : Pesakit.fromJson(json["pesakit"]),
    obats: json["obats"] == null ? [] : List<Obat>.from(json["obats"]!.map((x) => Obat.fromJson(x))),
    branches: json["branches"],
    totalHarga: json["total_harga"],
  );

  Map<String, dynamic> toJson() => {
    "pesakit": pesakit?.toJson(),
    "obats": obats == null ? [] : List<dynamic>.from(obats!.map((x) => x.toJson())),
    "branches": branches,
    "total_harga": totalHarga,
  };
}

class Branch {
  String? pesakitId;
  String? batchId;
  String? nama;
  String? statusBatch;
  String? tasker;
  String? tanggal;

  Branch({
    this.pesakitId,
    this.batchId,
    this.nama,
    this.statusBatch,
    this.tasker,
    this.tanggal,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    pesakitId: json["pesakit_id"],
    batchId: json["batch_id"],
    nama: json["nama"],
    statusBatch: json["status_batch"],
    tasker: json["tasker"],
    tanggal: json["tanggal"],
  );

  Map<String, dynamic> toJson() => {
    "pesakit_id": pesakitId,
    "batch_id": batchId,
    "nama": nama,
    "status_batch": statusBatch,
    "tasker": tasker,
    "tanggal": tanggal,
  };
}

class Obat {
  String? pesakitId;
  String? obatId;
  String? namaObat;
  String? hargaObat;
  String? jumlahObat;
  int? totalHarga;
  bool? isChecked;

  Obat({
    this.pesakitId,
    this.obatId,
    this.namaObat,
    this.hargaObat,
    this.jumlahObat,
    this.totalHarga,
    this.isChecked = false,
  });

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
    pesakitId: json["pesakit_id"],
    obatId: json["obat_id"],
    namaObat: json["nama_obat"],
    hargaObat: json["harga_obat"],
    jumlahObat: json["jumlah_obat"],
    totalHarga: json["total_harga"],
  );

  Map<String, dynamic> toJson() => {
    "pesakit_id": pesakitId,
    "obat_id": obatId,
    "nama_obat": namaObat,
    "harga_obat": hargaObat,
    "jumlah_obat": jumlahObat,
    "total_harga": totalHarga,
  };
}

class Pesakit {
  int? id;
  String? hospitalId;
  String? nama;
  String? tanggalLahir;
  String? diagnosis;
  String? jenisKelamin;
  String? height;
  String? weight;
  String? age;
  String? negeri;
  String? kodePos;
  dynamic bukti;
  String? houseNumber;
  String? phoneNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic branch;

  Pesakit({
    this.id,
    this.hospitalId,
    this.nama,
    this.tanggalLahir,
    this.diagnosis,
    this.jenisKelamin,
    this.height,
    this.weight,
    this.age,
    this.negeri,
    this.kodePos,
    this.bukti,
    this.houseNumber,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.branch,
  });

  factory Pesakit.fromJson(Map<String, dynamic> json) => Pesakit(
    id: json["id"],
    hospitalId: json["hospital_id"],
    nama: json["nama"],
    tanggalLahir: json["tanggal_lahir"],
    diagnosis: json["diagnosis"],
    jenisKelamin: json["jenis_kelamin"],
    height: json["height"],
    weight: json["weight"],
    age: json["age"],
    negeri: json["negeri"],
    kodePos: json["kode_pos"],
    bukti: json["bukti"],
    houseNumber: json["house_number"],
    phoneNumber: json["phone_number"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    branch: json["branch"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hospital_id": hospitalId,
    "nama": nama,
    "tanggal_lahir": tanggalLahir,
    "diagnosis": diagnosis,
    "jenis_kelamin": jenisKelamin,
    "height": height,
    "weight": weight,
    "age": age,
    "negeri": negeri,
    "kode_pos": kodePos,
    "bukti": bukti,
    "house_number": houseNumber,
    "phone_number": phoneNumber,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "branch": branch,
  };
}
