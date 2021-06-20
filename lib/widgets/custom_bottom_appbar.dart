import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final String text;

  const CustomBottomAppBar({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
              ),
              onPressed: () {},
              child: Text(
                text,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
