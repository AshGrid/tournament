import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/colors.dart';







Future<String> getInstalledVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  print("installed version");
  print(packageInfo.version);
  return packageInfo.version;
}



Future<String?> getLatestVersion() async {
  const String packageName = "com.abcevents.scoring"; // Replace with your app's package name
  final url = Uri.parse("https://play.google.com/store/apps/details?id=$packageName&hl=en&gl=US");

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final regex = RegExp(r'"softwareVersion"\s*:\s*"\s*([\d.]+)\s*"');
      final match = regex.firstMatch(response.body);
      if (match != null) {
        print("latest version");
        print(match.group(1));
        return  match.group(1);
      }
    }
  } catch (e) {
    print("Error fetching latest version: $e");
  }
  return null;
}



void checkForUpdate(BuildContext context) async {
  String installedVersion = await getInstalledVersion();
  String? latestVersion = await getLatestVersion();

  if (latestVersion != null && installedVersion != latestVersion) {
    showUpdateDialog(context, latestVersion);
  }
}

void showUpdateDialog(BuildContext context, String latestVersion) {
  showDialog(
    context: context,
    barrierDismissible: false, // Empêche la fermeture sans action
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.nav, // Fond rouge foncé
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Coins arrondis
        ),
        title: Text(
          "Mise à jour disponible",
          style: TextStyle(
            color: Colors.white, // Texte blanc
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Une nouvelle version ($latestVersion) est disponible. Veuillez mettre à jour pour une meilleure expérience.",
          style: TextStyle(
            color: Colors.white, // Texte blanc
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              "Plus tard",
              style: TextStyle(color: AppColors.secondaryColor), // Couleur secondaire
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              "Mettre à jour",
              style: TextStyle(color: AppColors.trophyBorder), // Couleur claire
            ),
            onPressed: () {
              Navigator.of(context).pop();
              openPlayStore();
            },
          ),
        ],
      );
    },
  );
}




void openPlayStore() async {
  const String packageName = "com.abcevents.scoring"; // Replace with your app's package name
  final Uri url = Uri.parse("https://play.google.com/store/apps/details?id=$packageName");

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    print("Could not open Play Store");
  }
}

