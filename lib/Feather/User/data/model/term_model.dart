
class TermModel{
int ? id;
String ? termsAndConditions;
String ? privacyPolicy;

TermModel({this.id, this.privacyPolicy, this.termsAndConditions});

factory TermModel.jsonData(data){
  return TermModel(
    id: data['id'],
    privacyPolicy: data['terms_and_conditions'],
    termsAndConditions: data['privacy_policy'],
  );
}
}


class FaqModel{
  String ? id;
  String ? question;
  String ? answer;
  String ? createdAt;
  String ? updatedAt;

  FaqModel({this.id, this.question, this.answer,this.createdAt,this.updatedAt});

  factory FaqModel.jsonData(data){
    return FaqModel(
      id: data['id'],
      question: data['question'],
      answer: data['answer'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

}
