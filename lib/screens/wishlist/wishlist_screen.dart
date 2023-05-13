import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/wishlist/wishlist_widget.dart';

import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/wishlist_provider.dart';
import '../../services/global_methods.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/text_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemList =
        wishlistProvider.getWishlistItem.values.toList().reversed.toList();
    final Color color = Utils(context).color;
    return wishlistItemList.isEmpty
        ? const EmptyScreen(
            title: 'Your cart is empty',
            subtitle: 'Add something to your cart',
            buttonText: 'Shop now',
            imagePath: 'assets/images/cart.png',
          )
        // ignore: dead_code
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const BackWidget(),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                color: color,
                text: 'Wishlist (${wishlistItemList.length}})',
                textSize: 22,
                isTitle: true,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: 'Empty your wishlist?',
                        subtitle: 'Are you sure?',
                        fct: () async {
                          await wishlistProvider.clearOnlineWishlist();
                          wishlistProvider.clearLocalWishlist();
                        },
                        context: context);
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: MasonryGridView.count(
              itemCount: wishlistItemList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 4,
              // crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemList[index],
                    child: const WishlistWidget());
              },
            ),
          );
  }
}
