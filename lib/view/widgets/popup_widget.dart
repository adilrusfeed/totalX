  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/home_controller.dart';


PopupMenuItem<String> buildPopupMenuItem(String value, String text,BuildContext context) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: Provider.of<HomeController>(context,listen: false).selectedFilter,
            activeColor: Colors.blue,
            onChanged: (value) {
              Provider.of<HomeController>(context, listen: false)
                  .setFilter(value!);
            },
          ),
          Text(text),
        ],
      ),
    );
  }