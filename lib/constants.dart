import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:snapshorts_app/controllers/auth_controller.dart';

//<------------------- Colors -------------------->
const buttonColor = Colors.indigo;
const backgroundColor = Colors.black12;
const borderColor = Colors.white70;
const textColor = Colors.white70;

// <------------------ Firebase ------------------>
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// <------------------ Controllers --------------->
var authController = AuthController.instance;
