import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../data/model/legal_issue.dart';

class LegalIssueItem extends StatelessWidget {
  final Function() onTap;
  final Function() onTapDelete;
  final Function() onTapDownload;

  const LegalIssueItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.onTapDelete,
    required this.onTapDownload,
  });

  final LegalIssue data;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Card(
      color: Colors.white10.withOpacity(.2),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title ?? "N/A",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.uploadedFileName ?? "N/A",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.issueStatus ?? "N/A",
                  style: const TextStyle(
                    fontSize: 13,
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onTapDelete,
                  icon: const Icon(
                    FeatherIcons.trash2,
                    color: Colors.redAccent,
                  ),
                ),
                IconButton(
                  onPressed: onTapDownload,
                  icon: const Icon(
                    FeatherIcons.download,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
