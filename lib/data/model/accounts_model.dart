import 'package:accounts/utils/client/models/cookie_network_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

final class Account extends BaseNetworkModel<Account> with EquatableMixin {

  Account({
    this.name,
    this.surname,
    this.birthdate,
    this.sallary,
    this.phoneNumber,
    this.identity,
    this.id,
  });


  String? name;
  String? surname;
  String? birthdate;
  String? sallary;
  String? phoneNumber;
  String? identity;
  String? id;

  @override
  List<Object?> get props =>
      [name, surname, birthdate, sallary, phoneNumber, identity, id];

  Account copyWith({
    String? name,
    String? surname,
    String? birthdate,
    String? sallary,
    String? phoneNumber,
    String? identity,
    String? id,
  }) {
    return Account(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      birthdate: birthdate ?? this.birthdate,
      sallary: sallary ?? this.sallary,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      identity: identity ?? this.identity,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'birthdate': birthdate,
      'sallary': sallary,
      'phoneNumber': phoneNumber,
      'identity': identity,
      'id': id,
    };
  }

  @override
  Account fromJson(Map<String, dynamic> json) {
    return Account(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      birthdate: json['birthdate'] as String?,
      sallary: json['sallary'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      identity: json['identity'] as String?,
      id: json['id'] as String?,
    );
  }


}
