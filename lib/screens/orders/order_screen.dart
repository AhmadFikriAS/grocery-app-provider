import 'package:flutter/material.dart';

import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/empty_screen.dart';

import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';
import 'order_widget.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/OrderScreen";
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    final Color color = Utils(context).color;
    return _isEmpty == true
        ? const EmptyScreen(
            title: 'Your order is empty',
            subtitle: 'Add something to your cart',
            buttonText: 'Shop now',
            imagePath: 'assets/images/cart.png',
          )
        : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Your orders (2)',
                color: color,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.separated(
                itemCount: 10,
                itemBuilder: (ctx, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 6,
                    ),
                    child: OrderWidget(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: color,
                    thickness: 1,
                  );
                }),
          );
  }
}
