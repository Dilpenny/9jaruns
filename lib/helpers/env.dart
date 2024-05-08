import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
class Env{
  void successToast(context, message, {IconData icon = Icons.check_circle}){
    toastification.show(
      icon: Icon(icon),
      backgroundColor: Color.fromRGBO(70, 184, 39, 1.0),
      context: context, // optional if you use ToastificationWrapper
      title: message,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  void toastToast(context, message, {IconData icon = Icons.error}){
    toastification.show(
      icon: Icon(icon),
      backgroundColor: Color.fromRGBO(184, 39, 39, 1.0),
      context: context, // optional if you use ToastificationWrapper
      title: message,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  void infoToast(context, message, {IconData icon = Icons.info}){
    toastification.show(
      icon: Icon(icon),
      backgroundColor: Color.fromRGBO(50, 137, 175, 1.0),
      context: context, // optional if you use ToastificationWrapper
      title: message,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}