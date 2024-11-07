part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DefaultComplaintEvent extends DashboardEvent {
  @override
  List<Object> get props => [];
}
// New event to add a complaint
class AddComplaintEvent extends DashboardEvent {
  final Complaint newComplaint;

  const AddComplaintEvent({required this.newComplaint});

  @override
  List<Object> get props => [newComplaint];
}

// New event to update a complaint (by its index)
class UpdateComplaintEvent extends DashboardEvent {
  final int complaintIndex; // Index of the complaint to update
  final Complaint updatedComplaint; // Updated complaint data

  const UpdateComplaintEvent({required this.complaintIndex, required this.updatedComplaint});

  @override
  List<Object> get props => [complaintIndex, updatedComplaint];
}

class SearchComplaintsEvent extends DashboardEvent {
  final String searchQuery;

  const SearchComplaintsEvent({required this.searchQuery});

  @override
  // TODO: implement props
  List<Object?> get props => [searchQuery];
}