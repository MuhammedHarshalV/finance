class CreateExpenseState {
  final String transactionType;
  final String category;
  final String description;
  final bool isSubmit;

  const CreateExpenseState({
    this.transactionType = '',
    this.category = '',
    this.description = '',
    this.isSubmit = false,
  });

  CreateExpenseState copyWith({
    String? transactionType,
    String? category,
    String? description,
    bool? isSubmit,
  }) {
    return CreateExpenseState(
      transactionType: transactionType ?? this.transactionType,
      category: category ?? this.category,
      description: description ?? this.description,
      isSubmit: isSubmit ?? this.isSubmit,
    );
  }
}
