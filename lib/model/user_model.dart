class UserModel{
  String? name;
  String? instituteName;
  String? departmentName;

  UserModel({required this.name, required this.instituteName, required this.departmentName});

   Map<String,dynamic> toJson(){
     final Map<String, dynamic> data = <String, dynamic>{};
     data["name"] = this.name;
     data["instituteName"] = this.instituteName;
     data["departmentName"] = this.departmentName;
    return data;
  }

  factory UserModel.fromJson(Map<String,dynamic> user){
    return UserModel(
      name: user["name"],
      instituteName: user["instituteName"],
      departmentName: user["departmentName"]
    );


  }

  @override
  String toString() {
    return ""
        "User Data : (name : $name, instituteName : $instituteName, departmentName : $departmentName)";
  }



}