// DevelopersNote

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khetexpert/themes/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class DevelopersNote extends StatelessWidget {
  const DevelopersNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pBackground(),
        automaticallyImplyLeading: false,
        title: Text(
          'Developers',
          textAlign: TextAlign.start,
          style: pwText(22, pText()),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: pBackground(),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
                child: Container(
                  width: 200,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'lib/assets/developer.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Text(
                  'Hello Users !!\nMy self Parth Thakor. \nI am an application developer from Government Engineering College Gandhinagar. This application is made by me and my team for Smart India Hackathon 2023. The purpose of this  application is to make realtime communication between farmer and expert and to solve plant related problems of farmer.If you like my work than follow me on LinkedIn or other social media platforms.',
                  textAlign: TextAlign.start,
                  style: pwText(16, pText()),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await launchUrl(Uri.parse('https://www.linkedin.com/in/parth-thakor-4a469b25b/'));
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.linkedin,
                        color: Color(0xFF176AED),
                        size: 50,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await launchUrl(Uri.parse('https://www.instagram.com/parth_thakor_24'));
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Color(0xFFED1775),
                        size: 50,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await launchUrl(Uri.parse('https://www.facebook.com/people/Parth-Thakor'));
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xFF176AED),
                        size: 50,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await launchUrl(Uri.parse('https://github.com/PARTH-THAKOR'));
                      },
                      child: FaIcon(
                        FontAwesomeIcons.github,
                        color: pText(),
                        size: 50,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await launchUrl(Uri.parse('https://chat.whatsapp.com/DVFQzFwsljMGGrfeKzqO2i'));
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Color(0xFF04A332),
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'KhetExpert.inc\nv2.0.1',
                      textAlign: TextAlign.center,
                      style: pwText(16, primary()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
