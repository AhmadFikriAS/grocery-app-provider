import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/feeds_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  }) : super(key: key);
  final String imagePath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: size.height * 0.4,
              ),
              const SizedBox(
                height: 2,
              ),
              const Text(
                'Whoopss!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                text: title,
                color: color,
                textSize: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: subtitle,
                color: color,
                textSize: 20,
              ),
              SizedBox(
                height: size.height * 0.10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: color, elevation: 0, backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: color,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                ),
                onPressed: () {
                  GlobalMethods.navigateTo(
                    ctx: context,
                    routeName: FeedsScreen.routeName,
                  );
                },
                child: TextWidget(
                  text: buttonText,
                  textSize: 20,
                  color: themeState ? Colors.white : Colors.grey.shade800,
                  isTitle: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
