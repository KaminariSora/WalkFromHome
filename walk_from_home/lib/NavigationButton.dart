import 'package:flutter/material.dart';

class Navigationbutton extends StatelessWidget {
  // Constructor (optional parameters can be added here)
  const Navigationbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: const Color.fromARGB(0, 86, 82, 82),
                side: const BorderSide(color: Colors.black, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              child: const Text(
                '< ย้อนกลับ',
                style: TextStyle(fontSize: 20,color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: const Color.fromARGB(0, 86, 82, 82),
                side: const BorderSide(color: Colors.black, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              child: const Text(
                'ต่อไป >',
                style: TextStyle(fontSize: 20,color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
