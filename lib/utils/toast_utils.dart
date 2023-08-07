import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class ToastUtils {
  static successToast(BuildContext context, {String? message}) {
    MotionToast toast = MotionToast.success(
      title: Text(
        message ?? 'Lorum Ipsum',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      description: const Text(''),
      position: MotionToastPosition.top,
      layoutOrientation: ToastOrientation.rtl,
      animationType: AnimationType.fromRight,
      barrierColor: Colors.black.withOpacity(0.2),
      animationCurve: Curves.easeInOut,
      enableAnimation: true,
      animationDuration: const Duration(milliseconds: 700),
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 80,
      dismissable: true,
    );
    toast.show(context);
    Future.delayed(const Duration(seconds: 2)).then((value) {
      toast.dismiss();
    });
  }

  static warningToast(BuildContext context, {required String message}) {
    MotionToast.warning(
      title: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text(''),
      position: MotionToastPosition.top,
      layoutOrientation: ToastOrientation.rtl,
      animationType: AnimationType.fromRight,
      barrierColor: Colors.black.withOpacity(0.2),
      animationCurve: Curves.easeInOut,
      enableAnimation: true,
      animationDuration: const Duration(milliseconds: 700),
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 80,
      dismissable: true,
      borderRadius: 0,
    ).show(context);
  }

  static errorToast(BuildContext context,
      {required String message, String? description}) {
    MotionToast toast = MotionToast.error(
      title: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      description: Text(description ?? ""),
      position: MotionToastPosition.top,
      layoutOrientation: ToastOrientation.rtl,
      animationType: AnimationType.fromRight,
      barrierColor: Colors.black.withOpacity(0.2),
      animationCurve: Curves.easeInOut,
      enableAnimation: true,
      animationDuration: const Duration(milliseconds: 700),
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 80,
      dismissable: true,
    );
    toast.show(context);
    Future.delayed(const Duration(seconds: 1)).then((value) {
      toast.dismiss();
    });
  }

  static infoToast(BuildContext context, {required String message}) {
    MotionToast.info(
      title: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text(''),
      position: MotionToastPosition.top,
      layoutOrientation: ToastOrientation.rtl,
      animationType: AnimationType.fromRight,
      barrierColor: Colors.black.withOpacity(0.2),
      animationCurve: Curves.easeInOut,
      enableAnimation: true,
      animationDuration: const Duration(milliseconds: 700),
      width: MediaQuery.sizeOf(context).width * 0.7,
      height: 80,
      dismissable: true,
    ).show(context);
  }
}
