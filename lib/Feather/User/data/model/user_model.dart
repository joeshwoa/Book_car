
class UserModel{
  String ? status;
  String ? message;
  DataUserModel ? dataUserModel;

  UserModel({this.dataUserModel, this.status, this.message});

  factory UserModel.jsonData(data){
    return UserModel(
      status: data['status'],
      dataUserModel: data['data']!=null ? DataUserModel.jsonData(data['data']) : null,
      message: data['message'],
    );
  }
}

class DataUserModel{
  String? id;
  String ? name;
  String ? email;
  String ? phone;
  String ? userType;
  String ? image;
  bool ? verified;
  String ? createdAt;
  String ? updatedAt;

  DataUserModel({this.id,this.name,this.email,this.phone,this.createdAt,this.updatedAt,this.userType,this.verified,this.image});

  factory DataUserModel.jsonData(data){
    //print(data);
    return DataUserModel(
      phone: data['phone'],
      name: data['name'],
      email: data['email'],
      id: data['_id'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      userType: data['userType'],
      verified: data['verified'],
      image: data['image'],
    );
  }
}
