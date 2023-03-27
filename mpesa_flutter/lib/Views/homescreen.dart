import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpesa_flutter/controls/MpesaSTKfun.dart';
import 'package:mpesa_flutter/controls/allcontrollers.dart';

class MainhomePage extends StatelessWidget {
  const MainhomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentController paymentcontroller = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'MPESA FLUTTER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: paymentcontroller.phoneNumbercontroller,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: paymentcontroller.amountcontroller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: () {
                  paymentcontroller.addCustomer();
                  startCheckout(
                    userPhone:
                        paymentcontroller.phoneNumbercontroller.text.trim(),
                    amount:
                        double.parse(paymentcontroller.amountcontroller.text)
                            .toDouble(),
                    // tillNumber: controller.tillNumber.text.trim(),
                  );
                },
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
