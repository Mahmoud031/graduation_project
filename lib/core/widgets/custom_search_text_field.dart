import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: ' Search',
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: 18,
          ),
          hintText: ' Search',
          suffixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
