// To parse this JSON data, do
//
//     final modelDokter = modelDokterFromJson(jsonString);

import 'dart:convert';

ModelDokter modelDokterFromJson(String str) => ModelDokter.fromJson(json.decode(str));

String modelDokterToJson(ModelDokter data) => json.encode(data.toJson());

class ModelDokter {
  bool? success;
  List<DataDokter>? data;
  String? tanggal;
  String? jam;
  String? message;

  ModelDokter({
    this.success,
    this.data,
    this.tanggal,
    this.jam,
    this.message,
  });

  factory ModelDokter.fromJson(Map<String, dynamic> json) => ModelDokter(
    success: json["success"],
    data: json["data"] == null ? [] : List<DataDokter>.from(json["data"]!.map((x) => DataDokter.fromJson(x))),
    tanggal: json["tanggal"],
    jam: json["jam"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "tanggal": tanggal,
    "jam": jam,
    "message": message,
  };
}

class DataDokter {
  int? id;
  int? taskerId;
  int? batchId;
  int? hospitalId;
  int? doctorId;
  String? statusBatch;
  DateTime? createdAt;
  DateTime? updatedAt;
  Hospital? hospital;
  Doctor? tasker;
  Doctor? doctor;
  Batch? batch;

  DataDokter({
    this.id,
    this.taskerId,
    this.batchId,
    this.hospitalId,
    this.doctorId,
    this.statusBatch,
    this.createdAt,
    this.updatedAt,
    this.hospital,
    this.tasker,
    this.doctor,
    this.batch,
  });

  factory DataDokter.fromJson(Map<String, dynamic> json) => DataDokter(
    id: json["id"],
    taskerId: json["tasker_id"],
    batchId: json["batch_id"],
    hospitalId: json["hospital_id"],
    doctorId: json["doctor_id"],
    statusBatch: json["status_batch"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    hospital: json["hospital"] == null ? null : Hospital.fromJson(json["hospital"]),
    tasker: json["tasker"] == null ? null : Doctor.fromJson(json["tasker"]),
    doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
    batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tasker_id": taskerId,
    "batch_id": batchId,
    "hospital_id": hospitalId,
    "doctor_id": doctorId,
    "status_batch": statusBatch,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "hospital": hospital?.toJson(),
    "tasker": tasker?.toJson(),
    "doctor": doctor?.toJson(),
    "batch": batch?.toJson(),
  };
}

class Batch {
  int? id;
  String? nama;
  int? userId;
  int? hospitalId;
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

  Batch({
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
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
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
  };
}

class Doctor {
  int? id;
  int? hospitalId;
  String? name;
  String? phoneNumber;
  String? level;
  String? email;
  String? firebaseNotifToken;
  String? profil;
  String? gender;
  String? specialist;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Doctor({
    this.id,
    this.hospitalId,
    this.name,
    this.phoneNumber,
    this.level,
    this.email,
    this.firebaseNotifToken,
    this.profil,
    this.gender,
    this.specialist,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    hospitalId: json["hospital_id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    level: json["level"],
    email: json["email"],
    firebaseNotifToken: json["firebase_notif_token"],
    profil: json["profil"],
    gender: json["gender"],
    specialist: json["specialist"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hospital_id": hospitalId,
    "name": name,
    "phone_number": phoneNumber,
    "level": level,
    "email": email,
    "firebase_notif_token": firebaseNotifToken,
    "profil": profil,
    "gender": gender,
    "specialist": specialist,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
