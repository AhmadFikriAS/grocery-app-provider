import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details.dart';

import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';

import '../../widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return ListTile(
      subtitle: const Text('Paid : \$12.0'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl:
            'https://png.pngtree.com/png-vector/20210731/ourlarge/pngtree-water-spinach-foods-food-png-image_3758990.jpg',
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(
        text: 'Title x12',
        color: color,
        textSize: 18,
      ),
      trailing: TextWidget(
        text: '29/06/2022',
        color: color,
        textSize: 18,
      ),
    );
  }
}
