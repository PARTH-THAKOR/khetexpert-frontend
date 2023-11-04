// Translation

import 'package:translator/translator.dart';

changeValueEnToOther(String post, String lang) async {
  String newPost = "";
  await GoogleTranslator().translate(post, to: lang).then((value) => newPost = value.toString());
  return newPost;
}

Future<String> changeValueEnToOtherApp(String post, String lang) async {
  String newPost = "";
  await GoogleTranslator().translate(post, to: lang).then((value) => newPost = value.toString());
  return newPost;
}

changeValueOtherToEn(String post) async {
  String newPost = "";
  await GoogleTranslator().translate(post, to: "en").then((value) => newPost = value.toString());
  return newPost;
}
