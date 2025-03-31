import 'package:demo_app/fetch_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> currencies = ["USD", "AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG",
  "AZN", "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB",
  "BRL", "BSD", "BTN", "BWP", "BYN", "BZD", "CAD", "CDF", "CHF", "CLP",
  "CNY", "COP", "CRC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD"];

String selectedCurrency = currencies.first;

double currencyValue = 0.0;

final TextEditingController _controller = TextEditingController();

class _HomePageState extends State<HomePage> {
  void convertCurrency() async {
    final rate = await FetchData(currency: selectedCurrency).getData();
    setState(() {
      currencyValue = double.parse(_controller.text) * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(selectedCurrency);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 51, 51),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Convert INR to $selectedCurrency',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              const SizedBox(height: 30),
              Text(
                '${currencyValue.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),

              const SizedBox(height: 30),

              // TextField + Drop Down Menu
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: Colors.black),

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Please enter the amount',
                            prefixIcon: Icon(Icons.currency_exchange_outlined),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: DropdownButton<String>(
                          underline: Container(color: Colors.black),
                          value: selectedCurrency,
                          hint: Text(currencies.first),
                          items:
                              currencies.map((String currency) {
                                return DropdownMenuItem<String>(
                                  value: currency,
                                  child: Center(child: Text(currency)),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCurrency = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: convertCurrency,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Convert', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
