part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final List<Compliant> compliant;
  const DashboardState({required this.compliant});
  DashboardState copyWith({
    List<Compliant>? compliant, // Can pass a new list or use the old one
  }) {
    return DashboardState(
      compliant: compliant ??
          this.compliant, // If `complaint` is not passed, use the current one
    );
  }

  @override
  List<Object> get props => [compliant,identityHashCode(this)];
}
