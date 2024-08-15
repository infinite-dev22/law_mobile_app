import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';

import '../../data/model/legal_certificate.dart';

class LegalCertificateItem extends StatelessWidget {
  final LegalCertificate data;
  final Function() onTap;
  final Function() onTapDelete;
  final Function() onTapEdit;
  final Function() onTapDownload;

  const LegalCertificateItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.onTapDelete,
    required this.onTapEdit,
    required this.onTapDownload,
  });

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
                  DateFormat('dd/MM/yyyy hh:mm a').format(data.createdAt!),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: onTapEdit,
                      icon: const Icon(FeatherIcons.edit),
                    ),
                    IconButton(
                      onPressed: onTapDelete,
                      icon: const Icon(
                        FeatherIcons.trash2,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onTapDownload,
                  icon: const Icon(FeatherIcons.download),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
