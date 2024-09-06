import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MwigoDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> menuItems;
  final bool disabled;
  final T? defaultValue;
  final Function(T? value)? onChanged;

  const MwigoDropdown(
      {super.key,
      required this.label,
      required this.menuItems,
      this.disabled = false,
      this.onChanged,
      this.defaultValue});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 50,
            child: DropdownButtonFormField2<T>(
              isExpanded: true,
              decoration: InputDecoration(
                enabled: !disabled,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 10.0,
                ),
                isDense: true,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              isDense: true,
              items: menuItems
                  .map((item) => DropdownMenuItem<T>(
                        value: item,
                        child: Text(
                          item.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select a $label';
                }
                return null;
              },
              onChanged: onChanged,
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
