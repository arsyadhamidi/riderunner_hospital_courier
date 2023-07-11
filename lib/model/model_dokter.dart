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
  String? cost;
  int? taskerId;
  String? tasker;
  String? profilTasker;
  String? phoneTasker;
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
  String? fullName;
  dynamic lastName;
  dynamic address;
  dynamic idCity;
  dynamic idState;
  dynamic postCode;
  dynamic birthDate;
  String? gender;
  String? email;
  DateTime? emailVerifiedAt;
  dynamic idArea;
  String? telp;
  String? level;
  int? accessLimit;
  dynamic loginSessionToken;
  String? firebaseNotifToken;
  String? deviceType;
  String? photo;
  String? saldo;
  dynamic idSubscribe;
  dynamic idPaket;
  dynamic motorcycleNumber;
  dynamic dummyOtp;
  dynamic code;
  String? status;
  int? hospitalId;
  String? specialist;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? aktif;
  dynamic apiToken;
  dynamic lastLoginAt;
  dynamic lastLoginIp;
  int? walletNominal;

  Doctor({
    this.id,
    this.fullName,
    this.lastName,
    this.address,
    this.idCity,
    this.idState,
    this.postCode,
    this.birthDate,
    this.gender,
    this.email,
    this.emailVerifiedAt,
    this.idArea,
    this.telp,
    this.level,
    this.accessLimit,
    this.loginSessionToken,
    this.firebaseNotifToken,
    this.deviceType,
    this.photo,
    this.saldo,
    this.idSubscribe,
    this.idPaket,
    this.motorcycleNumber,
    this.dummyOtp,
    this.code,
    this.status,
    this.hospitalId,
    this.specialist,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.aktif,
    this.apiToken,
    this.lastLoginAt,
    this.lastLoginIp,
    this.walletNominal,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    fullName: json["full_name"],
    lastName: json["last_name"],
    address: json["address"],
    idCity: json["id_city"],
    idState: json["id_state"],
    postCode: json["post_code"],
    birthDate: json["birth_date"],
    gender: json["gender"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    idArea: json["id_area"],
    telp: json["telp"],
    level: json["level"],
    accessLimit: json["access_limit"],
    loginSessionToken: json["login_session_token"],
    firebaseNotifToken: json["firebase_notif_token"],
    deviceType: json["device_type"],
    photo: json["photo"],
    saldo: json["saldo"],
    idSubscribe: json["id_subscribe"],
    idPaket: json["id_paket"],
    motorcycleNumber: json["motorcycle_number"],
    dummyOtp: json["dummy_otp"],
    code: json["code"],
    status: json["status"],
    hospitalId: json["hospital_id"],
    specialist: json["specialist"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    aktif: json["aktif"],
    apiToken: json["api_token"],
    lastLoginAt: json["last_login_at"],
    lastLoginIp: json["last_login_ip"],
    walletNominal: json["wallet_nominal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "last_name": lastName,
    "address": address,
    "id_city": idCity,
    "id_state": idState,
    "post_code": postCode,
    "birth_date": birthDate,
    "gender": gender,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "id_area": idArea,
    "telp": telp,
    "level": level,
    "access_limit": accessLimit,
    "login_session_token": loginSessionToken,
    "firebase_notif_token": firebaseNotifToken,
    "device_type": deviceType,
    "photo": photo,
    "saldo": saldo,
    "id_subscribe": idSubscribe,
    "id_paket": idPaket,
    "motorcycle_number": motorcycleNumber,
    "dummy_otp": dummyOtp,
    "code": code,
    "status": status,
    "hospital_id": hospitalId,
    "specialist": specialist,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "aktif": aktif,
    "api_token": apiToken,
    "last_login_at": lastLoginAt,
    "last_login_ip": lastLoginIp,
    "wallet_nominal": walletNominal,
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
