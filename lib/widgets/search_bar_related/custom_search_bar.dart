import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final bool readOnly;
  final VoidCallback? onTap;

  CustomSearchBar({
    Key? key,
    required this.onSearch,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.04,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          Icon(Icons.search_rounded, color: Color(0xff737373)),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              onChanged: widget.onSearch,
              decoration: InputDecoration(
                hintText: "Найдем что-то красивое",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
              },
            ),
        ],
      ),
    );
  }
}