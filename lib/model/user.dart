


class User1{
  String id;
  String name;
  String phone;
  String age;
  String? value;
  String date;

  User1(
  {
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.value,
    required this.date
});

  Map<String,dynamic> toJson(){
    return
       {
         "id":id,
         "name":name,
         "phone":phone,
         "age":age,
         "value":value,
         "date":date,

       };

  }


}