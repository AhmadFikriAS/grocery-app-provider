import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/inner_screens/product_details.dart';

import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../const/firebase_const.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/viewed_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import 'heart_btn.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItem.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItem.containsKey(productModel.id);

    final viewedProvider = Provider.of<ViewedProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            viewedProvider.addProductToHistory(productId: productModel.id);
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.width * 0.21,
                width: size.width * 0.2,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: productModel.title,
                        color: color,
                        maxLines: 1,
                        textSize: 20,
                        isTitle: true,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: HeartBtn(
                        productId: productModel.id,
                        isInWishlist: isInWishlist,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: PriceWidget(
                        price: productModel.price,
                        isOnSale: productModel.isOnSale,
                        textPrice: _quantityTextController.text,
                        salePrice: productModel.salePrice,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: FittedBox(
                              child: TextWidget(
                                color: color,
                                text: productModel.isPiece ? 'Piece' : 'kg',
                                textSize: 20,
                                isTitle: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              controller: _quantityTextController,
                              key: const ValueKey('10'),
                              style: TextStyle(
                                color: color,
                                fontSize: 18,
                              ),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              onChanged: (value) {
                                setState(() {});
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: isInCart
                      ? null
                      : () async {
                          final User? user = authInstance.currentUser;
                          if (user == null) {
                            GlobalMethods.errorDialog(
                                subtitle: 'No user found, Please login first',
                                context: context);
                            return;
                          }
                          await GlobalMethods.addToCart(
                              productId: productModel.id,
                              quantity: int.parse(_quantityTextController.text),
                              context: context);
                          await cartProvider.fetchCart();
                          // cartProvider.addProductsToCart(
                          //   productId: productModel.id,
                          //   quantity: int.parse(_quantityTextController.text),
                          // );
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).cardColor,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  child: TextWidget(
                    text: isInCart ? 'In-Cart' : 'Add to cart',
                    maxLines: 1,
                    color: color,
                    textSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
