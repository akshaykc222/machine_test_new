import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  String? id;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? mail;
  final double monthlyDue;
  final String? notes;
  final String city;
  final DateTime? joinedDate;

  final String address;
  CustomerModel({
    this.id,
    required this.city,
    required this.address,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.mail,
    required this.monthlyDue,
    this.notes,
    this.joinedDate,
  });

  factory CustomerModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return CustomerModel(
      id: doc.id,
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      mail: json['mail'],
      monthlyDue: json['monthlyDue'],
      notes: json['notes'],
      city: json['city'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['mail'] = mail;
    data['monthlyDue'] = monthlyDue;
    data['notes'] = notes;
    data['city'] = city;
    data['address'] = address;
    data['joinedDate'] = joinedDate;
    return data;
  }
}
