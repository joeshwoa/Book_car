
class PlacesModel{
  String ? id;
  String ? title;
  String ? address;
  String ? user;
  String ? createdAt;
  String ? updatedAt;

  PlacesModel(
      {this.title, this.id, this.createdAt, this.updatedAt, this.address, this.user,});

  factory PlacesModel.jsonData(data){
    return PlacesModel(
      title: data['title'],
      id: data['_id'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      address: data['address'],
      user: data['user'],
    );
  }
}