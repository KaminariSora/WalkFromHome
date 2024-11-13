import 'package:flutter/material.dart';

class Infromationsteps extends StatefulWidget {
  const Infromationsteps({super.key});

  @override
  State<Infromationsteps> createState() => _InfromationstepsState();
}

class _InfromationstepsState extends State<Infromationsteps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "แบบสอบถามเพื่อปรับเทียบระยะก้าว",
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'prompt',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 37,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 349,
                height: 127,
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ระยะทางที่ได้",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'prompt',
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "ในการตั้งค่าระยะก้าว",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'prompt',
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
