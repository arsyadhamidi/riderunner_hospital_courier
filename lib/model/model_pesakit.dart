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
  String? priceMy;

  ModelPesakit({
    this.success,
    this.data,
    this.message,
    this.price,
    this.priceMy,
  });

  factory ModelPesakit.fromJson(Map<String, dynamic> json) => ModelPesakit(
    success: json["success"],
    data: json["data"] == null ? [] : List<DataPesakit>.from(json["data"]!.map((x) => DataPesakit.fromJson(x))),
    message: json["message"],
    price: json["price"],
    priceMy: json["price_my"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "price": price,
    "price_my": priceMy,
  };
}

class DataPesakit {
  Pesakit? pesakit;
  List<Obat>? obats;
  Branches? branches;
  int? totalHarga;
  String? totalMy;
  dynamic proof;

  DataPesakit({
    this.pesakit,
    this.obats,
    this.branches,
    this.totalHarga,
    this.totalMy,
    this.proof,
  });

  factory DataPesakit.fromJson(Map<String, dynamic> json) => DataPesakit(
    pesakit: json["pesakit"] == null ? null : Pesakit.fromJson(json["pesakit"]),
    obats: json["obats"] == null ? [] : List<Obat>.from(json["obats"]!.map((x) => Obat.fromJson(x))),
    branches: json["branches"] == null ? null : Branches.fromJson(json["branches"]),
    totalHarga: json["total_harga"],
    totalMy: json["total_my"],
    proof: json["proof"],
  );

  Map<String, dynamic> toJson() => {
    "pesakit": pesakit?.toJson(),
    "obats": obats == null ? [] : List<dynamic>.from(obats!.map((x) => x.toJson())),
    "branches": branches?.toJson(),
    "total_harga": totalHarga,
    "total_my": totalMy,
    "proof": proof,
  };
}

class Branches {
  int? batchId;
  String? nama;
  String? statusBatch;
  dynamic tasker;
  String? tanggal;
  String? jam;
  String? updatedJam;

  Branches({
    this.batchId,
    this.nama,
    this.statusBatch,
    this.tasker,
    this.tanggal,
    this.jam,
    this.updatedJam,
  });

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
    batchId: json["batch_id"],
    nama: json["nama"],
    statusBatch: json["status_batch"],
    tasker: json["tasker"],
    tanggal: json["tanggal"],
    jam: json["jam"],
    updatedJam: json["updated_jam"],
  );

  Map<String, dynamic> toJson() => {
    "batch_id": batchId,
    "nama": nama,
    "status_batch": statusBatch,
    "tasker": tasker,
    "tanggal": tanggal,
    "jam": jam,
    "updated_jam": updatedJam,
  };
}

class Obat {
  int? obatId;
  String? namaObat;
  int? hargaObat;
  int? jumlahObat;
  int? totalHarga;
  String? totalMy;
  bool isChecked;

  Obat({
    this.obatId,
    this.namaObat,
    this.hargaObat,
    this.jumlahObat,
    this.totalHarga,
    this.totalMy,
    this.isChecked = false,
  });

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
    obatId: json["obat_id"],
    namaObat: json["nama_obat"],
    hargaObat: json["harga_obat"],
    jumlahObat: json["jumlah_obat"],
    totalHarga: json["total_harga"],
    totalMy: json["total_my"],
  );

  Map<String, dynamic> toJson() => {
    "obat_id": obatId,
    "nama_obat": namaObat,
    "harga_obat": hargaObat,
    "jumlah_obat": jumlahObat,
    "total_harga": totalHarga,
    "total_my": totalMy,
  };
}

class Pesakit {
  int? id;
  String? hospitalId;
  String? nama;
  String? noic;
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
    this.noic,
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
    noic: json["noic"],
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
    "noic": noic,
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
