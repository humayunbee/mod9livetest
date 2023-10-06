import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String selectedSize = "";
  Map<String, Color> buttonColors = {
    'S': Colors.grey,
    'M': Colors.grey,
    'L': Colors.grey,
    'XL': Colors.grey,
    'XXL': Colors.grey,
    'XXXL': Colors.grey,
  };

  void _updateButtonColor(String size) {
    setState(() {
      buttonColors.forEach((key, value) {
        buttonColors[key] = key == size ? Colors.orange : Colors.grey;
      });
      selectedSize = size;
    });
    _showSnackbar(size);
  }

  void _showSnackbar(String size) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected Size: $size'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> firstRowButtons = [];
    List<Widget> secondRowButtons = [];
    
    buttonColors.forEach((size, color) {
      final button = ElevatedButton(
        onPressed: () => _updateButtonColor(size),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Text(size),
      );
      
      if (size == 'XXL' || size == 'XXXL') {
        secondRowButtons.add(button);
      } else {
        firstRowButtons.add(button);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Size Selector'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: firstRowButtons,
            ),
            SizedBox(height: 16.0), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: secondRowButtons,
            ),
          ],
        ),
      ),
    );
  }
}
