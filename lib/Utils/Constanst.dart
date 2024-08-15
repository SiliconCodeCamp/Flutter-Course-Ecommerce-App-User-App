const String currencySymbol = '\$';
const String imageDirectory = 'UserPictures/';

const cities = [
'Amman',
'Beirut',
'Damascus',
'Istanbul',
'Riyadh',
'Dubai',
'Cairo',
'Baghdad'
'Sanaa'
'Doha'
 ];


abstract class OrderStatus {
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
  static const String returned = 'Returned';
}

abstract class PaymentMethods{
  static const String cod = 'Cash on Delivery';
  static const String online = 'Online';
}



