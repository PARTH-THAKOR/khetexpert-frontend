// Image Processing

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

agriculturalImageProcess(File image) async {
  bool agri = false;
  final inputImage = InputImage.fromFilePath(image.path);
  ImageLabeler imageLabeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));
  List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
  for (ImageLabel imageLabel in labels) {
    String lblText = imageLabel.label;
    double confidence = imageLabel.confidence * 100;
    if (lblText == "Plant" && confidence > 60.0) {
      agri = true;
    }
    if (lblText == "Plant" && confidence > 60.0) {
      if (lblText == "Insect" && confidence > 80.0) {
        agri = true;
      }
    }
    if (lblText == "Flower" && confidence > 70.0) {
      agri = true;
    }
    if (lblText == "Food" && confidence > 73.0) {
      agri = true;
    }
    if (lblText == "Vegetable" && confidence > 71.0) {
      agri = true;
    }
    if (lblText == "Plant" && confidence > 65.0) {
      if (lblText == "Fruit" && confidence > 52.0) {
        agri = true;
      }
    }
  }
  imageLabeler.close();
  return agri;
}

recognizeText(File image) async {
  final inputImage = InputImage.fromFilePath(image.path);
  final textDetector = TextRecognizer(script: TextRecognitionScript.latin);
  RecognizedText recognizedText = await textDetector.processImage(inputImage);
  await textDetector.close();
  String reco = "";
  String reco2 = "";
  for (TextBlock block in recognizedText.blocks) {
    for (TextLine line in block.lines) {
      reco = "$reco${line.text}";
      if (line.text.replaceAll(" ", "").isNumericOnly) {
        reco2 = line.text.replaceAll(" ", "");
      }
    }
  }
  reco = reco.replaceAll(" ", "");
  debugPrint(reco2);
  if (reco.contains('GovernmentofIndia') && reco2.toString().isNotEmpty) {
    return reco2;
  } else {
    Fluttertoast.showToast(msg: "Image is Not Aadhaar Card please enter valid Image");
    return "";
  }
}
