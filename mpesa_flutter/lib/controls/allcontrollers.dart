import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PaymentController extends GetxController {
  // FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  final phoneNumbercontroller = TextEditingController();
  final amountcontroller = TextEditingController();

  Future<void> addCustomer() {
    return customers
        .add({
          'phonenumber': phoneNumbercontroller.text,
          'amount': amountcontroller.text,
        })
        .then(
          (value) => print(
            'customer created successfully',
          ),
        )
        .catchError(
          (error) => print('falled to add customer ${error}'),
        );
  }
}
