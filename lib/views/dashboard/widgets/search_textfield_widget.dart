import 'package:flutter/material.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  const SearchTextFieldWidget(
      {super.key,
      this.hintText = 'Search...',
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
      ),
    );
  }
}
