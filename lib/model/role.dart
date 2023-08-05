class RoleResponse {
  final String date;
  final String message;
  final int status;
  final List<Role> data;

  RoleResponse({
    required this.date,
    required this.message,
    required this.status,
    required this.data,
  });

  factory RoleResponse.fromJson(Map<String, dynamic> json) => RoleResponse(
        date: json["date"],
        message: json["message"],
        status: json["status"],
        data: List<Role>.from(json["data"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Role {
  final int roleId;
  final String roleName;

  Role({
    required this.roleId,
    required this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        roleName: json["roleName"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
      };
}
