// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// class Option extends StatelessWidget {
//   const Option({
//     Key? key,
//     required this.text,
//     required this.index,
//     required this.press,
//   }) : super(key: key);

//   final String text;
//   final int index;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<QuestionController>(
//         init: QuestionController(),
//         builder: (qnController) {
//           Color getTheRightColor() {
//             if (qnController.isAnswered) {
//               if (index == qnController.correctAns) {
//                 return const Color(0xFF6AC259);
//               } else if (index == qnController.selectedAns &&
//                   qnController.selectedAns != qnController.correctAns) {
//                 return const Color(0xFFE92E30);
//               }
//             }
//             return Colors.grey;
//           }

//           IconData getTheRightIcon() {
//             return getTheRightColor() == const Color(0xFFE92E30)
//                 ? Icons.close
//                 : Icons.done;
//           }

//           return InkWell(
//             onTap: press,
//             child: Container(
//               margin: const EdgeInsets.only(top: 20, bottom: 20),
//               padding: const EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                   border: Border.all(color: getTheRightColor()),
//                   borderRadius: BorderRadius.circular(20)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("$text",
//                       style:
//                           TextStyle(color: getTheRightColor(), fontSize: 10)),
//                   Container(
//                     height: 18,
//                     width: 18,
//                     decoration: BoxDecoration(
//                         color: getTheRightColor() == Colors.grey
//                             ? Colors.transparent
//                             : getTheRightColor(),
//                         borderRadius: BorderRadius.circular(50),
//                         border: Border.all(color: getTheRightColor())),
//                     child: getTheRightColor() == Colors.grey
//                         ? null
//                         : Icon(getTheRightIcon(), size: 16),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  const Option({Key? key, required this.option, required this.color})
      : super(key: key);

  final String option;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: color, width: 3)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          trailing: const Spacer(
            flex: 2,
          ),
          title: Text(
            option,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
