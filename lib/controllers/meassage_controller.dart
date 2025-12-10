import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MassageController extends GetxController implements GetxService {
  bool isLoading = false;
  TextEditingController messageController = TextEditingController();
}
