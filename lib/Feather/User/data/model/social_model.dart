
class SocialModel{
  String ? id;
  String ? title;
  String ? icon;
  String ? link;
  String ? createdAt;
  String ? updatedAt;

  SocialModel(
      {this.updatedAt,
      this.createdAt,
      this.id,
      this.icon,
      this.title,
      this.link});

  factory SocialModel.jsonData(data){
    return SocialModel(
      updatedAt: data['updatedAt'],
      createdAt: data['createdAt'],
      id: data['_id'],
      title: data['title'],
      icon: data['icon'],
      link: data['link'],
    );
  }


}