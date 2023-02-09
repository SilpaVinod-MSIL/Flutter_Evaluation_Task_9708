import 'package:flutter/material.dart';
import 'package:flutter_evaluation_task_9708/screens/single_item_view.dart';
import 'screens/item_details_view.dart';

void main() {
  runApp(
      MaterialApp(debugShowCheckedModeBanner: false,
    home: SingleItemView(),
    routes: {
      ItemDetails.routeName:(ctx)=>ItemDetails(),
    },
  )
  );
}

