import 'package:flutter/material.dart';

import '../../../Global/Variables/colors.dart';
import '../../data/model/legal_issue.dart';

class LegalIssueItem extends StatelessWidget {
  const LegalIssueItem({super.key, required this.data});

  final LegalIssue data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildInfo(),
        )
      ],
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title ?? "N/A",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                data.uploadedFileName ?? "N/A",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          data.issueStatus ?? "N/A",
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          data.createdAt.toString(),
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
