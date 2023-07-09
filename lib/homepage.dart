import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> currencies = [];
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() {
    super.initState();
    getCurrencies().then((List<dynamic> currencies) {
      setState(() {
        this.currencies = currencies;
      });
    });
    //start periodic timer
    Timer.periodic(Duration(seconds: 30), (timer) {
      getCurrencies().then((value) {
        setState(() {
          currencies = value;
        });
      });
    });
  }

  Future<List<dynamic>> getCurrencies() async {
    const String cryptourl =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=500&convert=INR';
    http.Response response = await http.get(Uri.parse(cryptourl), headers: {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': 'fe4565d0-6556-452e-8f45-2d11b0c4116a'
    });
    Map<String, dynamic> data = json.decode(response.body);
    return data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto App')),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final Map<dynamic, dynamic> currency = currencies[index];
              final MaterialColor color = _colors[index % _colors.length];
              return _getListItem(currency, color);
            },
            itemCount: currencies.length,
          ),
        ),
      ],
    );
  }

  ListTile _getListItem(Map<dynamic, dynamic> currency, MaterialColor color) {
    final Map<String, dynamic> quote = currency['quote']['INR'];
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text("${currency['name'][0]}"),
      ),
      title: Text(
        "${currency["name"]}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(
        quote['price'].toStringAsFixed(2),
        quote['percent_change_1h'].toString(),
      ),
      // Text(
      //   "Price: ${quote['price'].toStringAsFixed(2)} INR",
      //   style: const TextStyle(fontWeight: FontWeight.bold),
      // ),
    );
  }

  Widget _getSubtitleText(String priceINR, String percentageChange) {
    double price = double.parse(priceINR);
    double change = double.parse(percentageChange);

    String formattedPrice = '$priceINR INR';
    String formattedChange = '1 hour: $percentageChange%';

    TextStyle changeTextStyle = TextStyle(
      color: change > 0 ? Colors.green : Colors.red,
      fontWeight: FontWeight.bold,
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: formattedPrice,
            style: const TextStyle(color: Colors.black),
          ),
          const TextSpan(text: '\t\t\t\t\t\t\t\t'),
          TextSpan(
            text: formattedChange,
            style: changeTextStyle,
          ),
        ],
      ),
    );
  }
}
