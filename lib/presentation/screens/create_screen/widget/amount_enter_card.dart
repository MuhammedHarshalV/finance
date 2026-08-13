import 'package:finance/controller/create_expense_controller/create_expense_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmountEnterCard extends ConsumerWidget {
  const AmountEnterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountController = ref.read(createExpensePrrovider.notifier);
    final controller = ref
        .read(createExpensePrrovider.notifier)
        .amountController;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'AMOUNT',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '₹',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8.h),
              IntrinsicWidth(
                child: TapRegion(
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                    ],
                    controller: controller,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      amountController.updateState(amount: num.tryParse(value));
                    },
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w900,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: ref.watch(createExpensePrrovider).amount == 0
                          ? '00'
                          : ref.watch(createExpensePrrovider).amount.toString(),
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 40.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
