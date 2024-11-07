import 'package:flutter/material.dart';

import '../model/complaint_model.dart';

class ComplaintBottomSheet extends StatefulWidget {
  final Compliant?
      complaint;
  final Function(Compliant) onSave; // Callback to save the updated complaint

  const ComplaintBottomSheet({super.key, this.complaint, required this.onSave});

  @override
  _ComplaintBottomSheetState createState() => _ComplaintBottomSheetState();
}

class _ComplaintBottomSheetState extends State<ComplaintBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _complaintNumberController;
  late TextEditingController _complaintDescriptionController;
  late TextEditingController _statusController;
  late TextEditingController _nameController;
  late TextEditingController _dateTimeController;

  // Initializing controllers
  @override
  void initState() {
    super.initState();

    _complaintNumberController =
        TextEditingController(text: widget.complaint?.complaintNumber ?? '');
    _complaintDescriptionController = TextEditingController(
        text: widget.complaint?.complaintDescription ?? '');
    _statusController =
        TextEditingController(text: widget.complaint?.status ?? '');
    _nameController = TextEditingController(text: widget.complaint?.name ?? '');
    _dateTimeController = TextEditingController(
        text: widget.complaint != null
            ? widget.complaint!.dateTime.toString()
            : DateTime.now().toString());
  }

  @override
  void dispose() {
    _complaintNumberController.dispose();
    _complaintDescriptionController.dispose();
    _statusController.dispose();
    _nameController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      // Create a new complaint object
      final updatedComplaint = Compliant(
        complaintNumber: _complaintNumberController.text,
        complaintDescription: _complaintDescriptionController.text,
        status: _statusController.text,
        name: _nameController.text,
        dateTime: DateTime.tryParse(_dateTimeController.text) ??
            DateTime.now(), // Ensure that date time is valid
      );

      // Pass the new complaint to the callback
      widget.onSave(updatedComplaint);

      // Close the bottom sheet
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom,left: 16,right: 16,top: 16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.complaint == null ? 'Add Complaint' : 'Update Complaint',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _complaintNumberController,
                decoration:
                    const InputDecoration(labelText: 'Complaint Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a complaint number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _complaintDescriptionController,
                decoration:
                    const InputDecoration(labelText: 'Complaint Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a complaint description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a status';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateTimeController,
                decoration: const InputDecoration(
                    labelText: 'Date Time (yyyy-MM-dd HH:mm)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _onSave,
                child: Text(widget.complaint == null
                    ? 'Add Complaint'
                    : 'Update Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
