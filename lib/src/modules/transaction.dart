import 'package:alfa_banck/src/modules/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionUsers {
  String name;
  String photo;
  Timestamp date;
  String value;
  Usuario user;

  TransactionUsers(this.name, this.photo, this.date, this.value, this.user);


  @override
  String toString() {
    return "Transations(Name: $name, photo: $photo, date: $date, value: $value)";
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photo': photo,
      'date': date,
      'value': value,
      'user': user.cpf
    };
  }
}