import 'package:flutter/material.dart';

class RakshakChatbotPage extends StatefulWidget {
  @override
  _RakshakChatbotPageState createState() => _RakshakChatbotPageState();
}

class _RakshakChatbotPageState extends State<RakshakChatbotPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hello! I'm Rakshak, your water expert chatbot. How can I assist you today?",
      isUser: false,
    ),
    ChatMessage(
      text: "Hi Rakshak! Can you tell me about the importance of water purity?",
      isUser: true,
    ),
    ChatMessage(
      text:
          "Certainly! Water purity is crucial for human health and the environment. Pure water ensures safe drinking, prevents waterborne diseases, and maintains ecological balance. It's essential for agriculture, industry, and sustaining all forms of life.",
      isUser: false,
    ),
    ChatMessage(
      text: "That's interesting. How can we test water purity at home?",
      isUser: true,
    ),
    ChatMessage(
      text:
          "Great question! There are several simple ways to test water purity at home:\n\n1. Use water testing strips to check pH levels and contaminants.\n2. Observe the water's clarity, odor, and taste.\n3. Use a TDS (Total Dissolved Solids) meter for a more accurate reading.\n4. For thorough analysis, consider using home water testing kits available in the market.",
      isUser: false,
    ),
    ChatMessage(
      text:
          "Thank you, Rakshak! Last question: What are some easy ways to conserve water?",
      isUser: true,
    ),
    ChatMessage(
      text:
          "I'm glad you asked! Here are some easy ways to conserve water:\n\n1. Fix leaky faucets and pipes.\n2. Take shorter showers.\n3. Use a bucket instead of a hose to wash your car.\n4. Water plants early in the morning or late in the evening to reduce evaporation.\n5. Install water-efficient appliances and fixtures.\n6. Collect and use rainwater for gardening.\n\nRemember, every drop counts!",
      isUser: false,
    ),
  ];

  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) =>
                  _messages[_messages.length - 1 - index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue.shade900),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(child: Text('R')),
            SizedBox(width: 8.0),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue.shade900 : Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                text,
                style: TextStyle(
                    color: isUser ? Colors.white : Colors.blue.shade900),
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 8.0),
            CircleAvatar(child: Text('U')),
          ],
        ],
      ),
    );
  }
}
