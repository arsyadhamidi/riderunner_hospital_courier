// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  String? status;
  String? message;
  User? user;
  String? token;

  ModelUser({
    this.status,
    this.message,
    this.user,
    this.token,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    status: json["status"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
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
  dynamic firebaseNotifToken;
  String? deviceType;
  String? photo;
  String? saldo;
  dynamic idSubscribe;
  dynamic idPaket;
  dynamic motorcycleNumber;
  dynamic dummyOtp;
  dynamic code;
  String? status;
  dynamic hospitalId;
  dynamic specialist;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? aktif;
  dynamic apiToken;
  dynamic lastLoginAt;
  dynamic lastLoginIp;
  int? walletNominal;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
