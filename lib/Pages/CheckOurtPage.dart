import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_app/Models/OrderModel.dart';
import 'package:ecommerce_user_app/Models/User_Address.dart';
import 'package:ecommerce_user_app/Pages/viewItemPage.dart';
import 'package:ecommerce_user_app/Provider/CartProvider.dart';
import 'package:ecommerce_user_app/Provider/OrderProvider.dart';
import 'package:ecommerce_user_app/Provider/UserProvider.dart';
import 'package:ecommerce_user_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Utils/Constanst.dart';
import '../Utils/ItemsUtils.dart';




class checkOutPage extends StatefulWidget {
  static const String routeName ="CheckOutPage";
  const checkOutPage({super.key});

  @override
  State<checkOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<checkOutPage> {
  @override
  void didChangeDependencies() {
    setAddress();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  String paymentMethodGroupValue = PaymentMethods.cod;
  String? city;
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                buildHeaderSection('Product Information'),
                buildProductInfoSection(),
                buildTotalAmountSection(),
                buildHeaderSection('Delivery Address'),
                buildDeliveryAddressSection(),
                buildHeaderSection('Payment Method'),
                buildPaymentMethodSection(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: _saveOrder,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: const Text('PLACE ORDER',style: TextStyle(color: Colors.black)),
            ),
          )
        ],
      ),
    );
  }

  Widget buildHeaderSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget buildProductInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<cartProvider>(
          builder: (context, provider, child) => Column(
            children: provider.cartList
                .map((cartModel) => ListTile(
              title: Text(cartModel.itemModel),
              trailing: Text(
                '${cartModel.quantity} x $currencySymbol${cartModel.price}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget buildTotalAmountSection() {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            title: const Text('Total Amount'),
            trailing: Consumer<cartProvider>(
              builder: (context, provider, child) => Text(
                '$currencySymbol${provider.getCartSubTotal()}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildDeliveryAddressSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Street Address',
              ),
            ),
            TextField(
              controller: postalCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Zip Code',
              ),
            ),
            DropdownButton<String>(
              value: city,
              hint: const Text('Select your city'),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  city = value;
                });
              },
              items: cities
                  .map((city) => DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentMethodSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Radio<String>(
              value: PaymentMethods.cod,
              groupValue: paymentMethodGroupValue,
              onChanged: (value) {
                setState(() {
                  paymentMethodGroupValue = value!;
                });
              },
            ),
            const Text(PaymentMethods.cod),
            Radio<String>(
              value: PaymentMethods.online,
              groupValue: paymentMethodGroupValue,
              onChanged: (value) {
                setState(() {
                  paymentMethodGroupValue = value!;
                });
              },
            ),
            const Text(PaymentMethods.online),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }



  void _saveOrder() async {
    if (addressController.text.isEmpty) {
      showMsg(context, 'Please provide your address');
      return;
    }
    if (postalCodeController.text.isEmpty) {
      showMsg(context, 'Please provide your zip code');
      return;
    }
    if (city == null) {
      showMsg(context, 'Please select your city');
      return;
    }



    // UserAddress
    final userAddress =user_address(
        streetAddress: addressController.text,
        city: city!,
        postcode: postalCodeController.text);

    final appUser =Provider.of<UserProvider>(context,listen: false).appUser;
    appUser!.useraddress = userAddress;
    // UserModel

    final order = OrderModel(
        orderId: makeOrderId
        , appuser: appUser,
        oderStatus: OrderStatus.pending,
        paymentMethod: paymentMethodGroupValue,
        totalAmount: Provider.of<cartProvider>(context,listen: false).getCartSubTotal(),
        orderDate: Timestamp.fromDate(DateTime.now()),
        itemsDetails: Provider.of<cartProvider>(context,listen: false).cartList);


    try{
      await Provider.of<orderProvider>(context,listen: false).saveOrder(order);

      await Provider.of<cartProvider>(context,listen: false).clearCart();
      EasyLoading.dismiss();
      showMsg(context, "Order Saved");

      context.goNamed(viewItemPage.routeName);



    }
    catch(err){
      EasyLoading.dismiss();
      showMsg(context, err.toString());

    }
  }


  void setAddress(){
    final appuser = Provider.of<UserProvider>(context,listen: false).appUser;

    if(appuser != null && appuser.useraddress != null){
      final userAddress = appuser.useraddress!;
      addressController.text=userAddress.streetAddress;
      postalCodeController.text = userAddress.postcode;
      city = userAddress.city;


    }
  }





}
