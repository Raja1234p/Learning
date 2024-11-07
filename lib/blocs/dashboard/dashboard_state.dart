part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final List<Complaint> complaint;
  const DashboardState({required this.complaint});
  DashboardState copyWith({
    List<Complaint>? complaint, // Can pass a new list or use the old one
  }) {
    return DashboardState(
      complaint: complaint ??
          this.complaint, // If `complaint` is not passed, use the current one
    );
  }

  @override
  List<Object> get props => [complaint,identityHashCode(this)];
}
