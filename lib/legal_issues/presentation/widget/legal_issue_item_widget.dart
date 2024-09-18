import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';

import '../../data/model/legal_issue.dart';

class LegalIssueItem extends StatelessWidget {
  final Function() onTap;
  final Function() onTapDelete;
  final Function() onTapEdit;
  final Function() onTapDownload;

  const LegalIssueItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.onTapDelete,
    required this.onTapEdit,
    required this.onTapDownload,
  });

  final LegalIssue data;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: [
                      DropdownMenuItem<String>(
                        value: "Edit",
                        onTap: onTapEdit,
                        child: SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Icon(FeatherIcons.edit,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 22),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (data.issueStatus != "Pending")
                        DropdownMenuItem<String>(
                          value: "Download",
                          onTap: onTapDownload,
                          child: SizedBox(
                            width: 150,
                            child: Row(
                              children: [
                                Icon(FeatherIcons.download,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 22),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "Download",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      DropdownMenuItem<String>(
                        value: "Delete",
                        onTap: onTapDelete,
                        child: const SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              Icon(FeatherIcons.trash2,
                                  color: Colors.red, size: 22),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    dropdownStyleData: DropdownStyleData(
                      width: 160,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      offset: const Offset(0, 8),
                    ),
                    onChanged: (value) {},
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
