import 'package:flutter/material.dart';

class Transactions {
final String id;
final String title;
final double amount;
final DateTime date;
Color color;

Transactions({
  required this.color, 
  required this.id, 
  required this.title, 
  required this.amount, 
  required this.date
  });
}