import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../views/dashboard/model/complaint_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<Complaint> complaints = [
    Complaint(
      complaintNumber: "C001",
      complaintDescription:
          "Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development to fill empty spaces in a layout that do not yet have content.",
      status: "Pending",
      name: "John Doe",
      dateTime: DateTime(2024, 10, 1, 10, 30), // Date: 2024-10-01 10:30
    ),
    Complaint(
      complaintNumber: "C002",
      complaintDescription:
          "Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development to fill empty spaces in a layout that do not yet have content.",
      status: "In Progress",
      name: "Jane Smith",
      dateTime: DateTime(2024, 10, 2, 14, 45), // Date: 2024-10-02 14:45
    ),
    Complaint(
      complaintNumber: "C003",
      complaintDescription:
          "Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development to fill empty spaces in a layout that do not yet have content.",
      status: "Resolved",
      name: "Alice Johnson",
      dateTime: DateTime(2024, 10, 3, 8, 0), // Date: 2024-10-03 08:00
    ),
    Complaint(
      complaintNumber: "C004",
      complaintDescription:
          "Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development to fill empty spaces in a layout that do not yet have content.",
      status: "Pending",
      name: "Bob Brown",
      dateTime: DateTime(2024, 10, 4, 18, 30), // Date: 2024-10-04 18:30
    ),
    Complaint(
      complaintNumber: "C005",
      complaintDescription:
          "Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development to fill empty spaces in a layout that do not yet have content.",
      status: "Resolved",
      name: "Charlie Davis",
      dateTime: DateTime(2024, 10, 5, 9, 15), // Date: 2024-10-05 09:15
    ),
  ];
  DashboardBloc() : super(const DashboardState(complaint: [])) {
    on<DefaultComplaintEvent>((event, emit) {
      emit(state.copyWith(complaint: complaints));
    });
    on<AddComplaintEvent>((event, emit) {
      complaints.add(event.newComplaint);

      emit(state.copyWith(complaint: List.from(complaints)));
    });
    on<UpdateComplaintEvent>((event, emit) {
      if (event.complaintIndex >= 0 &&
          event.complaintIndex < complaints.length) {
        complaints[event.complaintIndex] = event.updatedComplaint;
        emit(state.copyWith(complaint: List.from(complaints)));
      }
    });

    on<SearchComplaintsEvent>((event, emit) {
      // Filter complaints where the complaintNumber matches the search query (case-insensitive)
      List<Complaint> filteredComplaints = complaints.where((complaint) {
        return complaint.complaintNumber.toLowerCase().contains(
            event.searchQuery.toLowerCase()); // Matching on ticket number
      }).toList();

      emit(state.copyWith(complaint: filteredComplaints));
    });
  }
}
