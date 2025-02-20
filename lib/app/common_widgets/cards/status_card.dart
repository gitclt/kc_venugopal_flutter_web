import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({super.key, required this.status});

  /// Get the background and text color based on the status
  Map<String, Color> _getStatusColors(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return {
          "bg": const Color(0xFFFFFFC5),
          "text": const Color(0xFFFFC000)
        }; // Yellow
      case "support requested":
        return {"bg": const Color(0xFFFFF3CD), "text": const Color(0xFF856404)};
      case "request accepted":
        return {
          "bg": const Color(0xFFD4EDDA),
          "text": const Color(0xFF155724)
        }; // Green
      case "attended":
        return {
          "bg": const Color(0xFFCCE5FF),
          "text": const Color(0xFF004085)
        }; // Blue
      case "completed":
        return {
          "bg": const Color(0xFFC3E6CB),
          "text": const Color(0xFF155724)
        }; // Green
      case "opened":
        return {
          "bg": const Color(0xFFFFD5B6),
          "text": const Color(0xFF8B4513)
        }; // Orange
      case "processing":
        return {
          "bg": const Color(0xFFE2E3E5),
          "text": const Color(0xFF383D41)
        }; // Gray
      case "action 1":
        return {
          "bg": const Color(0xFFF5C6CB),
          "text": const Color(0xFF721C24)
        }; // Red
      case "followup":
        return {
          "bg": const Color(0xFFFFEEB0),
          "text": const Color(0xFF856404)
        }; // Yellowish
      case "closed":
        return {
          "bg": const Color(0xFFD6D8DB),
          "text": const Color(0xFF1B1E21)
        }; // Dark Gray
      default:
        return {"bg": Colors.grey.shade300, "text": Colors.black};
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getStatusColors(status);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: colors["bg"],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            color: colors["text"],
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
