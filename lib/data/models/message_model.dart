class MessageModel {
  final String id;
  final String text;
  final DateTime time;
  final bool isMe;

  MessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });
}

final List<MessageModel> messagesList = [
  MessageModel(
    id: '1',
    text: 'Hey! How are you?',
    time: DateTime.now().subtract(const Duration(minutes: 23)),
    isMe: false,
  ),
  MessageModel(
    id: '2',
    text: 'I am good — working on the Flutter project. You?',
    time: DateTime.now().subtract(const Duration(minutes: 18)),
    isMe: true,
  ),
  MessageModel(
    id: '3',
    text: 'Nice. Let me know if you need help with gradle or plugins.',
    time: DateTime.now().subtract(const Duration(minutes: 4)),
    isMe: false,
  ),
];
