import 'package:finance/core/themes/colors.dart';
import 'package:finance/presentation/common_widgets/glass_container.dart';
import 'package:finance/presentation/screens/create_screen/widget/amount_enter_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key});

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  // State variables
  bool isExpense = true;
  String selectedCategory = 'Transport';
  DateTime selectedDate = DateTime(2026, 6, 30); // Default to date in image
  final TextEditingController _amountController = TextEditingController(
    text: '200',
  );
  final TextEditingController _descriptionController = TextEditingController();

  final Color primaryDark = const Color(0xFF0F172A);
  final Color textGrey = const Color(0xFF6B7280);
  final Color inputBgColor = const Color(0xFFF3F4F6);

  // Method to handle date picking
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: false,
            snap: false,
            // Snaps into full view when scrolling up
            elevation: 4,
            shadowColor: Colors.black45,
            expandedHeight: 70.0, // Slightly taller for a premium feel
            backgroundColor:
                Colors.transparent, // Required to show the gradient
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A2980), // Deep stylish blue
                    Color(0xFF26D0CE), // Vibrant teal
                  ],

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Row(
              children: [
                InkWell(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: GlassContainer(
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(360),
                    border: Border.all(color: AppColors.appWhite),
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: AppColors.appWhite,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'FinanceTrack',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            actions: [
              GlassContainer(
                border: Border.all(color: AppColors.appWhite),
                borderRadius: BorderRadius.circular(360),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.person_2_outlined,
                          color: AppColors.appWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  AmountEnterCard(),
                  SizedBox(height: 20),
                  _buildFormCard(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: GlassContainer(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              // Handle save action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryDark,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.check_circle, size: 20),
            label: const Text(
              'Save Entry',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  // --- AMOUNT CARD ---

  // --- FORM CARD ---
  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.appBottomNavColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel('Transaction Type'),
          const SizedBox(height: 8),
          _buildTransactionTypeToggle(),
          const SizedBox(height: 20),

          _buildSectionLabel('Category'),
          const SizedBox(height: 8),
          _buildDropdownField(),
          const SizedBox(height: 20),

          _buildSectionLabel('Date'),
          const SizedBox(height: 8),
          _buildDateField(),
          const SizedBox(height: 20),

          _buildSectionLabel('Description (Optional)'),
          const SizedBox(height: 8),
          _buildDescriptionField(),
        ],
      ),
    );
  }

  // Helper for small grey labels above fields
  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // --- CUSTOM TOGGLE SWITCH ---
  Widget _buildTransactionTypeToggle() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isExpense = true),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isExpense ? AppColors.appBlack : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isExpense
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      size: 16,
                      color: isExpense ? AppColors.appWhite : textGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Expense',
                      style: TextStyle(
                        color: isExpense ? AppColors.appWhite : textGrey,
                        fontWeight: isExpense
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isExpense = false),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: !isExpense ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: !isExpense
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 16,
                      color: !isExpense ? primaryDark : textGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Income',
                      style: TextStyle(
                        color: !isExpense ? primaryDark : textGrey,
                        fontWeight: !isExpense
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- DROPDOWN FIELD ---
  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: textGrey),
          style: TextStyle(
            color: primaryDark,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedCategory = newValue;
              });
            }
          },
          items:
              <String>[
                'Transport',
                'Food',
                'Shopping',
                'Bills',
                'Entertainment',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }

  // --- DATE PICKER FIELD ---
  Widget _buildDateField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: inputBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('dd-MM-yyyy').format(selectedDate),
              style: TextStyle(
                color: primaryDark,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.calendar_today_outlined, color: primaryDark, size: 20),
          ],
        ),
      ),
    );
  }

  // --- DESCRIPTION TEXT FIELD ---
  Widget _buildDescriptionField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _descriptionController,
        maxLines: 3,
        style: TextStyle(color: primaryDark, fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Add a note or tag...',
          hintStyle: TextStyle(color: textGrey, fontSize: 15),
        ),
      ),
    );
  }
}
