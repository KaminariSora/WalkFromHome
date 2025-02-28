// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../models/FAQBeforeTest.dart';
// ignore_for_file: prefer_final_fields

class FAQBeforeTestProvider extends ChangeNotifier {
  FAQBeforeTest _faq = FAQBeforeTest(walkingType: '', walkingStride: '');

  FAQBeforeTest get faq => _faq;

  // Function to update walkingType
  void updateWalkingType(String walkingType) {
    _faq.walkingType = walkingType;
    notifyListeners();
  }

  void updateWalkingStride(String WalkingStride) {
    _faq.walkingStride = WalkingStride;
    notifyListeners();
  }

  // Function to update multiple variables
  void updateFAQ({String? walkingType, String? walkingStride}) {
    if (walkingType != null) _faq.walkingType = walkingType;
    if (walkingStride != null) _faq.walkingStride = walkingStride;
    notifyListeners();
  }
}
