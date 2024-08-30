import 'package:flutter/material.dart';

import 'package:dirm_attorneys_mobile/Global/Variables/colors.dart';
import 'package:dirm_attorneys_mobile/queries/data/model/query.dart';

class QueryItem extends StatelessWidget {
  const QueryItem({super.key, required this.data});

  final Query data;

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
          data.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: Text(
            data.comment,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          data.status!,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
