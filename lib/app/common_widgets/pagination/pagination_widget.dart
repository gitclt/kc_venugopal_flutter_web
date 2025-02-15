import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

class PaginationWidget extends StatefulWidget {
  final int totalPages;
  final int currentPage;
  final Alignment? alignment;
  final ValueChanged<int> onPageSelected;

  const PaginationWidget({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageSelected,
    this.alignment,
  });

  @override
  PaginationWidgetState createState() => PaginationWidgetState();
}

class PaginationWidgetState extends State<PaginationWidget> {
  final int visiblePages = 4;
  late int startPage;
  late int endPage;

  @override
  void initState() {
    super.initState();
    _updateVisiblePages();
  }

  void _updateVisiblePages() {
    startPage = ((widget.currentPage - 1) ~/ visiblePages) * visiblePages + 1;
    endPage = (startPage + visiblePages - 1).clamp(1, widget.totalPages);
  }

  @override
  void didUpdateWidget(covariant PaginationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPage != widget.currentPage) {
      _updateVisiblePages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Left Arrow Button
        GestureDetector(
          onTap: widget.currentPage > 1
              ? () => widget.onPageSelected(widget.currentPage - 1)
              : null,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  widget.currentPage > 1 ? Colors.grey[300] : Colors.grey[200],
            ),
            child: const Icon(Icons.chevron_left, color: Colors.black54),
          ),
        ),
        const SizedBox(width: 8),

        // Page Numbers
        for (int page = startPage; page <= endPage; page++) ...[
          GestureDetector(
            onTap: () => widget.onPageSelected(page),
            child: Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.currentPage == page
                    ? AppColor.primary
                    : Colors.white,
                border: Border.all(
                  color: widget.currentPage == page
                      ? AppColor.primary
                      : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  page.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.currentPage == page
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
        const SizedBox(width: 8),

        // Right Arrow Button
        GestureDetector(
          onTap: widget.currentPage < widget.totalPages
              ? () => widget.onPageSelected(widget.currentPage + 1)
              : null,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.currentPage < widget.totalPages
                  ? Colors.grey[300]
                  : Colors.grey[200],
            ),
            child: const Icon(Icons.chevron_right, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
