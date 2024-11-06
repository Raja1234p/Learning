import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning/common_widgets/text_widget.dart';
import 'package:learning/views/dashboard/widgets/customer_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Create your\nComplaints',
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AppText(
                          text: 'Have something to rant about?',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white,
                        )
                      ],
                    ),

                    Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child:  const Icon(
                        Icons.add,
                        color: Color(0xFFDE7A72),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
