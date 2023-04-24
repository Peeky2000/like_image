import 'package:flutter/material.dart';
import 'package:likeimage/my_app.dart';
import 'package:likeimage/providers/item_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: const MyApp(),
    ),
  );
}
