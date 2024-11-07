class Complaint {
  final String complaintNumber;
  final String complaintDescription;
  final String status;
  final String name;
  final DateTime dateTime;
  Complaint(
      {required this.complaintNumber,
      required this.complaintDescription,
      required this.status,
      required this.name,
      required this.dateTime});
}
