// Enum to indicate order fulfillment location
enum OrderLocation { delivery, pickup }

// Address class
class Address {
  final String street;
  final String city;
  final String country;

  Address({required this.street, required this.city, required this.country});

  @override
  String toString() => '$street, $city, $country';
}

// Product class
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price}) {
    if (price < 0) {
      throw Exception('Product price cannot be negative.');
    }
  }

  @override
  String toString() => '$name (\$$price)';
}

// Customer class
class Customer {
  final int id;
  final String name;
  final String email;
  final Address address;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  @override
  String toString() => '$name <$email>';
}

// OrderItem class (represents one product in an order)
class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({required this.product, required this.quantity}) {
    if (quantity <= 0) {
      throw Exception('Quantity must be greater than 0.');
    }
  }

  // Method to calculate total price of this item
  double get totalPrice => product.price * quantity;

  @override
  String toString() =>
      '${product.name} x $quantity = \$${totalPrice.toStringAsFixed(2)}';
}

// Order class
class Order {
  final int id;
  final Customer customer;
  final List<OrderItem> items;
  final OrderLocation orderLocation;
  final Address? deliveryAddress; // Nullable

  Order({
    required this.id,
    required this.customer,
    required this.items,
    required this.orderLocation,
    this.deliveryAddress,
  }) {
    // Validation using enum logic
    if (orderLocation == OrderLocation.delivery && deliveryAddress == null) {
      throw Exception('Delivery orders must have a delivery address.');
    }
    if (orderLocation == OrderLocation.pickup && deliveryAddress != null) {
      throw Exception('Pickup orders should not have a delivery address.');
    }
  }

  // Compute total order amount
  double get totalAmount {
    double total = 0;
    for (var item in items) {
      total += item.totalPrice;
    }
    return total;
  }

  @override
  String toString() {
    final locationInfo = orderLocation == OrderLocation.delivery
        ? 'Delivered to: $deliveryAddress'
        : 'Pickup at shop';
    final itemList = items.map((i) => '   • $i').join('\n');
    return '''
=============================
Order #$id
Customer: ${customer.name}
Order Type: ${orderLocation.name.toUpperCase()}
$locationInfo

Items:
$itemList

Total: \$${totalAmount.toStringAsFixed(2)}
=============================
''';
  }
}

// Main function for testing
void main() {
  // Create products
  var laptop = Product(id: 1, name: 'Laptop', price: 1200.0);
  var mouse = Product(id: 2, name: 'Wireless Mouse', price: 25.0);

  // Create customer with address
  var address = Address(
    street: '123 Main St',
    city: 'Phnom Penh',
    country: 'Cambodia',
  );
  var customer = Customer(
    id: 1,
    name: 'Alice',
    email: 'alice@example.com',
    address: address,
  );

  // Create order items
  var item1 = OrderItem(product: laptop, quantity: 1);
  var item2 = OrderItem(product: mouse, quantity: 2);

  // Test Case 1: Valid Delivery Order
  var deliveryOrder = Order(
    id: 1001,
    customer: customer,
    items: [item1, item2],
    orderLocation: OrderLocation.delivery,
    deliveryAddress: address,
  );
  print(deliveryOrder);

  // Test Case 2: Invalid Pickup (has address) — should throw error
  try {
    var invalidPickup = Order(
      id: 1002,
      customer: customer,
      items: [item1],
      orderLocation: OrderLocation.pickup,
      deliveryAddress: address, // Not allowed
    );
    print(invalidPickup);
  } catch (e) {
    print('Error: $e');
  }
}