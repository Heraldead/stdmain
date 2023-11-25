import 'package:flutter/material.dart';

class DatingScreen extends StatelessWidget {
  const DatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Данный раздел находится в разработке. В будущем, в данном разделе вы сможете знакомиться и находить себе пару. Мы также открыты к вашим предложениям и идеям. Для этого вы можете связаться с нами через почту, указанную в маркетах, откуда вы устанавливали данное приложение.\n С уважением, команда STD.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
