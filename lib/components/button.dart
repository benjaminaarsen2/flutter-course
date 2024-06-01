import 'package:flutter/material.dart';

// class CustomButton extends ElevatedButton {
//   CustomButton(
//       {required Key key,
//       required VoidCallback onPressed,
//       required Widget child})
//       : super(
//             key: key,
//             onPressed: onPressed,
//             child: Ink(
//                 decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [Colors.deepPurpleAccent, Colors.deepPurple])),
//                 child: child),
//             style: ButtonStyle(
//               shape: WidgetStateProperty.all<OutlinedBorder>(
//                   RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(3))),
//               backgroundColor:
//                   WidgetStateProperty.all<Color>(Colors.deepPurple),

//               // padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
//               //     const EdgeInsets.all(15)),
//             ));
// }

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required Key key, required this.onPressed, required this.child})
      : super(key: key);
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.deepPurple),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
