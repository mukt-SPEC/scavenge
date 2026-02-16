enum WasteType {
  paper('Paper'),
  metal('Metal'),
  plastic('Plastic'),
  others('Others');

  final String label;
  const WasteType(this.label);
}

enum TransactionType { recycle, trade }

enum UserType { agent, customer }
