// To parse this JSON data, do
//
//     final modelDokter = modelDokterFromJson(jsonString);

import 'dart:convert';

ModelDokter modelDokterFromJson(String str) => ModelDokter.fromJson(json.decode(str));

String modelDokterToJson(ModelDokter data) => json.encode(data.toJson());

class ModelDokter {
  bool? success;
  List<DataDokter>? data;
  String? message;

  ModelDokter({
    this.success,
    this.data,
    this.message,
  });

  factory ModelDokter.fromJson(Map<String, dynamic> json) => ModelDokter(
    success: json["success"],
    data: json["data"] == null ? [] : List<DataDokter>.from(json["data"]!.map((x) => DataDokter.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class DataDokter {
  int? id;
  String? nama;
  String? userId;
  String? tanggal;
  String? jam;
  String? statusBatch;
  dynamic tasker;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? hospital;
  String? specialist;
  List<Pesakit>? pesakit;

  DataDokter({
    this.id,
    this.nama,
    this.userId,
    this.tanggal,
    this.jam,
    this.statusBatch,
    this.tasker,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.hospital,
    this.specialist,
    this.pesakit,
  });

  factory DataDokter.fromJson(Map<String, dynamic> json) => DataDokter(
    id: json["id"],
    nama: json["nama"],
    userId: json["user_id"],
    tanggal: json["tanggal"],
    jam: json["jam"],
    statusBatch: json["status_batch"],
    tasker: json["tasker"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    name: json["name"],
    hospital: json["hospital"],
    specialist: json["specialist"],
    pesakit: json["pesakit"] == null ? [] : List<Pesakit>.from(json["pesakit"]!.map((x) => Pesakit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "user_id": userId,
    "tanggal": tanggal,
    "jam": jam,
    "status_batch": statusBatch,
    "tasker": tasker,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "hospital": hospital,
    "specialist": specialist,
    "pesakit": pesakit == null ? [] : List<dynamic>.from(pesakit!.map((x) => x.toJson())),
  };
}

class Pesakit {
  int? id;
  String? userId;
  String? batchId;
  String? pesakitId;
  String? obatId;
  String? jumlahObat;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pesakit({
    this.id,
    this.userId,
    this.batchId,
    this.pesakitId,
    this.obatId,
    this.jumlahObat,
    this.createdAt,
    this.updatedAt,
  });

  factory Pesakit.fromJson(Map<String, dynamic> json) => Pesakit(
    id: json["id"],
    userId: json["user_id"],
    batchId: json["batch_id"],
    pesakitId: json["pesakit_id"],
    obatId: json["obat_id"],
    jumlahObat: json["jumlah_obat"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "batch_id": batchId,
    "pesakit_id": pesakitId,
    "obat_id": obatId,
    "jumlah_obat": jumlahObat,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
