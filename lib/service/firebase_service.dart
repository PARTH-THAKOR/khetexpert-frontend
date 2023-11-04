// FireStore Service

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khetexpert/states/GetX/chatbot/chatbot_getx.dart';
import '../api/api.dart';
import '../language/translator.dart';
import '../settings/settings.dart';

// ChatBotStream
chatBotStream() {
  return FirebaseFirestore.instance.collection('chatbot').doc(farmer.phoneNumber!).collection("openAI").snapshots();
}

// ChatbotFirestoreMessageUpload
chatbotFirestoreMessageUpload(TextEditingController chatTexter, ChatBotController controller) async {
  final fstore = FirebaseFirestore.instance.collection('chatbot');
  chatTexter.text.toString().isEmpty
      ? Fluttertoast.showToast(msg: "Empty Message")
      : fstore.doc(farmer.phoneNumber!).collection("openAI").doc("que").set({"set": "que", "title": chatTexter.text.toString()}).then((value) async {
          controller.gptResponce.value = true;
          FirebaseFirestore.instance.collection('chatbot').doc(farmer.phoneNumber!).collection("openAI").doc("zans").delete();
          await chatBotApiCall(await changeValueOtherToEn(chatTexter.text.toString()), controller);
          chatTexter.clear();
        }).onError((error, stackTrace) {
          Fluttertoast.showToast(msg: error.toString());
          chatTexter.clear();
        });
}

// DiseaseQuestionStream
diseaseQuestionStream() {
  return FirebaseFirestore.instance
      .collection('disease')
      .doc(farmer.state!)
      .collection('disease_detection')
      .where('phoneNumber', isEqualTo: farmer.phoneNumber!)
      .orderBy("docId", descending: true)
      .snapshots();
}

// DiseaseQuestionDelete
diseaseQuestionDelete(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
  FirebaseFirestore.instance
      .collection('disease')
      .doc(farmer.state!)
      .collection('disease_detection')
      .doc(snapshot.data!.docs[index]['docId'])
      .delete();
  Fluttertoast.showToast(msg: "Question Deleted");
}

// ImageUploadOnStorage
imageUploadOnStorage(File? image) async {
  var docId = DateTime.now().microsecondsSinceEpoch.toString();
  fs.Reference storage = fs.FirebaseStorage.instance.ref(docId);
  fs.UploadTask uploadTask = storage.putFile(image!.absolute);
  return await (await uploadTask).ref.getDownloadURL();
}

// DiseaseQuestionsForExpert
diseaseQuestionsForExpert() {
  return FirebaseFirestore.instance
      .collection('disease')
      .doc(expert.stateName!)
      .collection('disease_detection')
      .orderBy("docId", descending: true)
      .snapshots();
}

// BlogStream
blogStream() {
  return FirebaseFirestore.instance.collection('blogs').orderBy("blogId", descending: true).snapshots();
}

// ExpertBlogStream
expertBlogStream() {
  return FirebaseFirestore.instance
      .collection('blogs')
      .where('expertEmail', isEqualTo: expert.expertEmailId!)
      .orderBy("blogId", descending: true)
      .snapshots();
}

// BlogDeleteForExpert
blogDeleteForExpert(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
  FirebaseFirestore.instance.collection('blogs').doc(snapshot.data!.docs[index]['blogId']).delete();
  Fluttertoast.showToast(msg: "Blog Deleted");
}

// DoubtStreamForFarmer
doubtStreamForFarmer() {
  return FirebaseFirestore.instance
      .collection('doubts')
      .doc(farmer.state!)
      .collection("doubt_solutions")
      .where("phoneNumber", isEqualTo: farmer.phoneNumber!)
      .orderBy('docId', descending: true)
      .snapshots();
}

// DoubtDeleteForFarmer
doubtDeleteForFarmer(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
  FirebaseFirestore.instance.collection('doubts').doc(farmer.state!).collection("doubt_solutions").doc(snapshot.data!.docs[index]['docId']).delete();
  Fluttertoast.showToast(msg: "Question Deleted");
}

// doubtStreamForExpert
doubtStreamForExpert() {
  return FirebaseFirestore.instance
      .collection('doubts')
      .doc(expert.stateName!)
      .collection("doubt_solutions")
      .orderBy('docId', descending: true)
      .snapshots();
}

// AppointmentDeleteForFarmer
appointmentDeleteForFarmer(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
  FirebaseFirestore.instance.collection('appointment').doc(snapshot.data!.docs[index]['docId']).delete();
  Fluttertoast.showToast(msg: "Meeting Canceled");
}

// AcceptedAppointmentForFarmer
acceptedAppointmentForFarmer() {
  return FirebaseFirestore.instance
      .collection('appointment')
      .where('farmerMobileNumber', isEqualTo: farmer.phoneNumber!)
      .where('accepted', isEqualTo: true)
      .where('rejected', isEqualTo: false)
      .orderBy("docId", descending: true)
      .snapshots();
}

// RequestedAppointmentForFarmer
requestedAppointmentForFarmer() {
  return FirebaseFirestore.instance
      .collection('appointment')
      .where('farmerMobileNumber', isEqualTo: farmer.phoneNumber!)
      .where('accepted', isEqualTo: false)
      .orderBy("docId", descending: true)
      .snapshots();
}

// AcceptedAppointmentForExpert
acceptedAppointmentForExpert() {
  return FirebaseFirestore.instance
      .collection('appointment')
      .where('expertEmailId', isEqualTo: expert.expertEmailId!)
      .where('accepted', isEqualTo: true)
      .where('rejected', isEqualTo: false)
      .orderBy("docId", descending: true)
      .snapshots();
}

// RequestedAppointmentForExpert
requestedAppointmentForExpert() {
  return FirebaseFirestore.instance
      .collection('appointment')
      .where('expertEmailId', isEqualTo: expert.expertEmailId!)
      .where('accepted', isEqualTo: false)
      .where('rejected', isEqualTo: false)
      .orderBy("docId", descending: true)
      .snapshots();
}
