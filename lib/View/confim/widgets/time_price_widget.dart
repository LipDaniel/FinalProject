import 'package:flutter/material.dart';
import 'package:projectsem4/ulits/constraint.dart';

class TimeAndPriceWidget extends StatelessWidget {
  const TimeAndPriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      children: [
                        Text(
                          'SGN',
                          style: TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 24,
                              color: AppConstraint.mainColor),
                        ),
                        Text(
                          '1:00 PM',
                          style: TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 12,
                              color: AppConstraint.mainColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Image.asset(
                        'assets/image/icon_arrow_right.png',
                        scale: 1.5,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      children: [
                        Text(
                          'BER',
                          style: TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 24,
                              color: AppConstraint.mainColor),
                        ),
                        Text(
                          '2:30 PM',
                          style: TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 12,
                              color: AppConstraint.mainColor),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Fri, 13 Sep, 2023',
                  style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 16,
                      color: AppConstraint.mainColor),
                )
              ],
            )),
        const Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '\$51',
                          style: TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 16,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '\$59',
                          style: TextStyle(
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 16,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '\$110',
                  style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Montserrat-Bold',
                      color: AppConstraint.mainColor),
                ),
              ],
            ))
      ],
    );
  }
}
