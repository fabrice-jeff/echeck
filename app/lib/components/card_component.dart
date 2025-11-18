import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';
class CardComponent extends StatelessWidget {
  const CardComponent({super.key});

  @override
  Widget build(BuildContext context) {
      return Container(
          height: 200,
          margin: EdgeInsets.only(right: 20),
          width: MediaQuery.of(context).size.width - 60,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.color1,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1.5
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "UBA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 17
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Credit Card",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                        ),
                        child: Image.asset(
                          'assets/pictures/puce.png',
                          fit: BoxFit.contain,
                          width: 50,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                        ),
                        child: Image.asset(
                          'assets/pictures/connect.png',
                          fit: BoxFit.contain,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "BJ00034554556",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontSize: 17
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "00000",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.maxFinite,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "John DOE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            fontSize: 17
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "EXPIRE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                          fontSize: 13
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "DATE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                          fontSize: 13
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "00/00/00",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                fontSize: 17
                            ),
                          ),
                        ],
                      )
                    ),

                  ],
                )
              ),
            ],
          ),
      );
  }
  
}