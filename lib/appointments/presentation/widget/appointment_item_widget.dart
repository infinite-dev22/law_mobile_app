import 'package:flutter/material.dart';

import '../../../Global/Variables/colors.dart';
import '../../data/model/appointment.dart';

class AppointmentItem extends StatelessWidget {
  const AppointmentItem({super.key, required this.data});

  final Appointment data;

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
        ),Expanded(
          child: Text(
            data.appointmentDate!,
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
