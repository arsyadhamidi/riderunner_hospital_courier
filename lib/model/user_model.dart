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
  dynamic name;
  String? phoneNumber;
  String? level;
  dynamic email;
  dynamic profil;
  dynamic gender;
  dynamic specialist;
  dynamic hospital;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.level,
    this.email,
    this.profil,
    this.gender,
    this.specialist,
    this.hospital,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    level: json["level"],
    email: json["email"],
    profil: json["profil"],
    gender: json["gender"],
    specialist: json["specialist"],
    hospital: json["hospital"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone_number": phoneNumber,
    "level": level,
    "email": email,
    "profil": profil,
    "gender": gender,
    "specialist": specialist,
    "hospital": hospital,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
