import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductInfo {
  final String name;
  final int price;

  ProductInfo(this.name, this.price);
}

final products = [
  ProductInfo("Iphone 11", 11000000),
  ProductInfo("Iphone 14", 36500000),
  ProductInfo("SamSung Galaxy 1", 10),
  ProductInfo("SamSung Galaxy 2", 60),
  ProductInfo("SamSung Galaxy 3", 13216531),
  ProductInfo("SamSung Galaxy 4", 432132),
  ProductInfo("SamSung Galaxy 5", 165132),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentProductIndex = 0;
  int? _inputtedPrice;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 80)),
            Text(products[_currentProductIndex].name),
            const Padding(padding: EdgeInsets.only(top: 40)),
            SizedBox(
              width: 200,
              child: TextField(
                key: const Key('priceInput'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  _inputtedPrice = int.tryParse(value);
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result =
                      _inputtedPrice == products[_currentProductIndex].price
                          ? 'pass'
                          : 'fail';
                  // if (_currentProductIndex < 6) {
                  //   _currentProductIndex++;
                  // }
                });
              },
              child: const Text('Check'),
            ),
            SizedBox(
              height: 8,
            ),
            Visibility(
              visible: _result.isNotEmpty,
              child: Text(
                _result,
                key: const Key('result'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Visibility(
              visible: _result.isNotEmpty,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result = '';
                    if (_currentProductIndex < 6) {
                      _currentProductIndex++;
                    }
                  });
                },
                child: const Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
