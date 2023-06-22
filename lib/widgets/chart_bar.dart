import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key? key, 
  required this.label, 
  required this.spendingAmount, 
  required this.spendingPercentage, 
  required this.categoryColor
  }) : super(key: key);
  
  final String label;
  final double spendingAmount;
  final double spendingPercentage;
  final Color categoryColor;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.11,
            child: SizedBox(
              width: 50,
              child: FittedBox(
                child: Text(
                  '${spendingAmount.toStringAsFixed(0)} zł',
                  style: Theme.of(context).textTheme.bodyText1,
                  )
                ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, 
                      width: 1.5
                      ),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  )
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05
            ),
          SizedBox(
            height: constraints.maxHeight * 0.11,
            child: FittedBox(
              child: Text(label,
              style: Theme.of(context).textTheme.bodyText1,),
            )
            )
        ],
      );
    },
    );
  }
}