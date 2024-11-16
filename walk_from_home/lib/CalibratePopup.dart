import 'package:flutter/material.dart';
import 'InfromationSteps.dart';

class Calibratepopup extends StatefulWidget {
  const Calibratepopup({super.key});

  @override
  State<Calibratepopup> createState() => _CalibratepopupState();
}

class _CalibratepopupState extends State<Calibratepopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(16.0),
          // border: Border.all(color: Colors.blue, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "คุณต้องการปรับเทียบระยะการเดินหรือไม่",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'prompt',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: const Color.fromARGB(0, 86, 82, 82),
                side: const BorderSide(color: Colors.black, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Infromationsteps()));
                },
                child: const Text(
                  "ปรับเทียบ",
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'prompt',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: const Color.fromARGB(0, 86, 82, 82),
                side: const BorderSide(color: Colors.black, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.push(context,
                  //   MaterialPageRoute(builder: (context) => const Infromationsteps()));
                },
                child: const Text(
                  "ข้าม",
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'prompt',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
