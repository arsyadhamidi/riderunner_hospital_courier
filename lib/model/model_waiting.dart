// To parse this JSON data, do
//
//     final modelWaiting = modelWaitingFromJson(jsonString);

import 'dart:convert';

ModelWaiting modelWaitingFromJson(String str) => ModelWaiting.fromJson(json.decode(str));

String modelWaitingToJson(ModelWaiting data) => json.encode(data.toJson());

class ModelWaiting {
  bool? success;
  String? tanggal;
  String? waktu;
  Data? data;
  String? message;

  ModelWaiting({
    this.success,
    this.tanggal,
    this.waktu,
    this.data,
    this.message,
  });

  factory ModelWaiting.fromJson(Map<String, dynamic> json) => ModelWaiting(
    success: json["success"],
    tanggal: json["tanggal"],
    waktu: json["waktu"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "tanggal": tanggal,
    "waktu": waktu,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  int? id;
  String? nama;
  String? userId;
  String? hospitalId;
  String? tanggal;
  String? jam;
  String? statusBatch;
  dynamic cost;
  dynamic taskerId;
  dynamic tasker;
  dynamic profilTasker;
  dynamic phoneTasker;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? specialist;
  String? profil;
  List<Pesakit>? pesakit;
  Hospital? hospital;

  Data({
    this.id,
    this.nama,
    this.userId,
    this.hospitalId,
    this.tanggal,
    this.jam,
    this.statusBatch,
    this.cost,
    this.taskerId,
    this.tasker,
    this.profilTasker,
    this.phoneTasker,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.specialist,
    this.profil,
    this.pesakit,
    this.hospital,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    nama: json["nama"],
    userId: json["user_id"],
    hospitalId: json["hospital_id"],
    tanggal: json["tanggal"],
    jam: json["jam"],
    statusBatch: json["status_batch"],
    cost: json["cost"],
    taskerId: json["tasker_id"],
    tasker: json["tasker"],
    profilTasker: json["profil_tasker"],
    phoneTasker: json["phone_tasker"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    name: json["name"],
    specialist: json["specialist"],
    profil: json["profil"],
    pesakit: json["pesakit"] == null ? [] : List<Pesakit>.from(json["pesakit"]!.map((x) => Pesakit.fromJson(x))),
    hospital: json["hospital"] == null ? null : Hospital.fromJson(json["hospital"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "user_id": userId,
    "hospital_id": hospitalId,
    "tanggal": tanggal,
    "jam": jam,
    "status_batch": statusBatch,
    "cost": cost,
    "tasker_id": taskerId,
    "tasker": tasker,
    "profil_tasker": profilTasker,
    "phone_tasker": phoneTasker,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "specialist": specialist,
    "profil": profil,
    "pesakit": pesakit == null ? [] : List<dynamic>.from(pesakit!.map((x) => x.toJson())),
    "hospital": hospital?.toJson(),
  };
}

class Hospital {
  int? id;
  String? rumahSakit;
  String? latitude;
  String? longitude;
  String? alamat;

  Hospital({
    this.id,
    this.rumahSakit,
    this.latitude,
    this.longitude,
    this.alamat,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
    id: json["id"],
    rumahSakit: json["rumah_sakit"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    alamat: json["alamat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rumah_sakit": rumahSakit,
    "latitude": latitude,
    "longitude": longitude,
    "alamat": alamat,
  };
}

class Pesakit {
  int? id;
  String? userId;
  String? batchId;
  String? pesakitId;
  String? obatId;
  dynamic proof;
  String? jumlahObat;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pesakit({
    this.id,
    this.userId,
    this.batchId,
    this.pesakitId,
    this.obatId,
    this.proof,
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
    proof: json["proof"],
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
    "proof": proof,
    "jumlah_obat": jumlahObat,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
