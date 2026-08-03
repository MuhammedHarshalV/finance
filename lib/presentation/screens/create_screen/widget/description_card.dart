import 'package:finance/controller/create_expense_controller/create_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DescriptionCard extends ConsumerWidget {
  DescriptionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref
        .read(createExpensePrrovider.notifier)
        .descriptionController;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TapRegion(
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        child: TextField(
          controller: controller,
          onChanged: (value) {
            ref.read(createExpensePrrovider.notifier).updateState(desc: value);
          },
          maxLines: 3,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: ref.watch(createExpensePrrovider).description.isEmpty
                ? 'Add a note or tag...'
                : ref.watch(createExpensePrrovider).description,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
