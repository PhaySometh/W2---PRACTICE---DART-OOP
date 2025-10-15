enum Skill { FLUTTER, DART, OTHER }

class Address {
  final String _street;
  final String _city;
  final String _zipCode;

  const Address({
    required String street,
    required String city,
    required String zipCode,
  }) : _street = street,
       _city = city,
       _zipCode = zipCode;

  String get street => _street;
  String get city => _city;
  String get zipCode => _zipCode;

  @override
  String toString() => "$_street, $_city ($_zipCode)";
}

class Employee {
  final String _name;
  static const double _baseSalary = 40000.0;
  final List<Skill> _skills;
  final Address _address;
  final double _yearsOfExperience;

  Employee({
    required String name,
    required List<Skill> skills,
    required Address address,
    required double yearsOfExperience,
  }) : _name = name,
       _skills = skills,
       _address = address,
       _yearsOfExperience = yearsOfExperience;

  Employee.mobileDeveloper({
    required String name,
    required Address address,
    required double yearsOfExperience,
  }) : _name = name,
       _skills = const [Skill.FLUTTER, Skill.DART],
       _address = address,
       _yearsOfExperience = yearsOfExperience;

  String get name => _name;
  List<Skill> get skills => List.unmodifiable(_skills);
  Address get address => _address;
  double get yearsOfExperience => _yearsOfExperience;

  double computeSalary() {
    double total = _baseSalary + (_yearsOfExperience * 2000);

    for (var skill in _skills) {
      switch (skill) {
        case Skill.FLUTTER:
          total += 5000;
          break;
        case Skill.DART:
          total += 3000;
          break;
        case Skill.OTHER:
          total += 1000;
          break;
      }
    }

    return total;
  }

  void printDetails() {
    print('Employee: $_name');
    print('Experience: $_yearsOfExperience year(s)');
    print('Skills: ${_skills.map((s) => s.name).join(', ')}');
    print('Address: $_address');
    print('Computed Salary: \$${computeSalary()}');
    print('--------------------------------------');
  }
}

void main() {
  const address1 = Address(
    street: "123 Main St",
    city: "Phnom Penh",
    zipCode: "12000",
  );
  const address2 = Address(
    street: "456 Riverside",
    city: "Siem Reap",
    zipCode: "17000",
  );

  var emp1 = Employee(
    name: "Ronan",
    skills: [Skill.OTHER, Skill.DART],
    address: address1,
    yearsOfExperience: 3,
  );

  var emp2 = Employee.mobileDeveloper(
    name: "Sokea",
    address: address2,
    yearsOfExperience: 2,
  );

  emp1.printDetails();
  emp2.printDetails();
}
