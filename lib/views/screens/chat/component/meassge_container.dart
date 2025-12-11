// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:lekra/data/models/message_model.dart';
// import 'package:lekra/services/constants.dart';
// import 'package:lekra/services/theme.dart';

// class MassageContainer extends StatelessWidget {
//   final MessageModel messageModel;
//   const MassageContainer({super.key, required this.messageModel});

//   @override
//   Widget build(BuildContext context) {
//     final timeString = DateFormat.Hm().format(messageModel.time);
//     final bubbleColor = messageModel.isMe ? primaryColor : greyLight;
//     final textColor = messageModel.isMe ? white : Colors.black87;
//     const radius = Radius.circular(14);
//     return Align(
//       alignment:
//           messageModel.isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 280),
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//           decoration: BoxDecoration(
//             color: bubbleColor,
//             borderRadius: BorderRadius.only(
//               topLeft: radius,
//               topRight: radius,
//               bottomLeft: messageModel.isMe ? radius : const Radius.circular(4),
//               bottomRight:
//                   messageModel.isMe ? const Radius.circular(4) : radius,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.03),
//                 blurRadius: 4,
//                 offset: const Offset(0, 2),
//               )
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 messageModel.text,
//                 style: Helper(context).textTheme.bodyMedium?.copyWith(
//                       color: textColor,
//                       height: 1.25,
//                     ),
//               ),
//               const SizedBox(height: 6),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     timeString,
//                     style: Helper(context).textTheme.bodySmall?.copyWith(
//                           color: textColor.withValues(alpha: 0.8),
//                         ),
//                   ),
//                   const SizedBox(width: 6),
//                   if (messageModel.isMe)
//                     Icon(
//                       Icons.done_all,
//                       size: 14,
//                       color: textColor.withValues(alpha: .85),
//                     )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
