import 'package:finance/controller/create_expense_controller/create_expense_controller.dart';
import 'package:finance/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.appBottomNavColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
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
              color: AppColors.appBlack,
              fontSize: 12,
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
                  color: AppColors.appBlack,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
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
                      color: AppColors.appBlack,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: ref.watch(createExpensePrrovider).amount == 0
                          ? '00'
                          : ref.watch(createExpensePrrovider).amount.toString(),
                      hintStyle: TextStyle(color: AppColors.appBlack),
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
