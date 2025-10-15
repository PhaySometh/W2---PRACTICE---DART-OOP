class BankAccount {
  // TODO
  int _accountId;
  double _accountBalance;
  final String _accountHolder;

  BankAccount({
    required int accountId,
    required double accountBalance,
    required String accountHolder,
  }) : _accountId = accountId,
       _accountBalance = accountBalance,
       _accountHolder = accountHolder;

  int get accountId => _accountId;
  double get accountBalance => _accountBalance;
  String get accountHolder => _accountHolder;

  // create a getter rather than method becuase in the main it class balance instead of balance()
  double get balance => _accountBalance;

  double withdraw(double amount) {
    if (_accountBalance - amount < 0) {
      throw Exception("Insufficient balance for withdrawal!");
    }
    _accountBalance -= amount;
    return _accountBalance;
  }

  double credit(double amount) {
    _accountBalance += amount;
    return _accountBalance;
  }
}

class Bank {
  // TODO
  final String _bankName;
  final List<BankAccount> _bankAccount;

  Bank({required String bankName}) : _bankName = bankName, _bankAccount = [];

  String get bankName => _bankName;
  List<BankAccount> get bankAccount => List.unmodifiable(_bankAccount);

  BankAccount createAccount(int accountId, String accountHolder) {
    for (var account in _bankAccount) {
      if (account.accountId == accountId) {
        throw Exception("Account with ID: $accountId already exists!");
      }
    }
    var newAccount = BankAccount(
      accountId: accountId,
      accountBalance: 0.0,
      accountHolder: accountHolder,
    );

    _bankAccount.add(newAccount);
    return newAccount;
  }
}

void main() {
  Bank myBank = Bank(bankName: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
