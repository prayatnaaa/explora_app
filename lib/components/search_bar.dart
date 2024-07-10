import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final void Function(String)? onChanged;
  const SearchBar({super.key, required this.onChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      decoration: const InputDecoration(
        labelText: 'Search Member',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
