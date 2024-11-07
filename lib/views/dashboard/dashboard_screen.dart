import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/blocs/dashboard/dashboard_bloc.dart';
import 'package:learning/common_widgets/text_widget.dart';
import 'package:learning/views/dashboard/widgets/bottom_sheet.dart';
import 'package:learning/views/dashboard/widgets/custom_card_widget.dart';
import 'package:learning/views/dashboard/widgets/customer_container.dart';
import 'package:learning/views/dashboard/widgets/search_textfield_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return ComplaintBottomSheet(
                              onSave: (newComplaint) {
                                context.read<DashboardBloc>().add(
                                    AddComplaintEvent(
                                        newComplaint: newComplaint));
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Color(0xFFDE7A72),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                 SearchTextFieldWidget(
                   onChanged: (query){
                     context.read<DashboardBloc>().add(SearchComplaintsEvent(searchQuery: query));

                   },
                 ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<DashboardBloc, DashboardState>(
            buildWhen: (previousState, currentState) {
              // Only rebuild if the complaints list has changed
              return previousState.complaint != currentState.complaint;
            },
            builder: (context, state) {
              return Expanded(
                child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: state.complaint.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ComplaintBottomSheet(
                                complaint: state.complaint[
                                    index], // Pass the complaint to edit
                                onSave: (updatedComplaint) {
                                  // Call your Bloc to update the complaint
                                  context.read<DashboardBloc>().add(
                                        UpdateComplaintEvent(
                                          complaintIndex: index,
                                          updatedComplaint: updatedComplaint,
                                        ),
                                      );
                                },
                              );
                            },
                          );
                        },
                        child: ShadowedContainer(
                          complaint: state.complaint[index],
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
