import 'package:flutter/material.dart';
import 'package:learning/common_widgets/text_widget.dart';

import '../model/complaint_model.dart';

class ShadowedContainer extends StatelessWidget {
  final Compliant complaint;
  const ShadowedContainer({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: 'Complaint Number',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff676A6C),
                  ),
                  const SizedBox(height: 5,),
                  AppText(
                    text: complaint.complaintNumber,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: complaint.status.contains('Resolved')
                        ? Colors.green
                        : const Color(0xffDE7A72)),
                child: Center(
                  child: AppText(
                    text: complaint.status,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person,
                    color: Color(0xffDE7A72),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  AppText(
                    text: complaint.name,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Color(0xffDE7A72),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  AppText(
                    text: complaint.dateTime.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const AppText(
            text: 'Description',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 10,
          ),
          AppText(
            text: complaint.complaintDescription,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ],
      ), // Child widget placed inside the container
    );
  }
}
