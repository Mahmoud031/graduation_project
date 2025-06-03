import 'package:flutter/material.dart';

class RejectionReasonDialog extends StatefulWidget {
  final Function(String) onConfirm;
  final VoidCallback onCancel;

  const RejectionReasonDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<RejectionReasonDialog> createState() => _RejectionReasonDialogState();
}

class _RejectionReasonDialogState extends State<RejectionReasonDialog> {
  final TextEditingController _reasonController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      setState(() {
        _errorText = 'Please provide a reason for rejection';
      });
      return;
    }
    widget.onConfirm(reason);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rejection Reason'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please provide a reason for rejecting this donation:',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _reasonController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Enter rejection reason...',
              border: const OutlineInputBorder(),
              errorText: _errorText,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.onCancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _handleConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirm Rejection'),
        ),
      ],
    );
  }
} 