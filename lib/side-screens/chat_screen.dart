import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(text: "tos ban lg ark ot", isSent: false, timestamp: "7:04"),
    Message(
        text: "Maybe ban lg\nTea yub tic\nCuz jet tver ka ngea sala hx lov hay",
        isSent: true,
        timestamp: "7:05"),
    Message(text: "vaii rank hesss bro", isSent: false, timestamp: "3:33 PM"),
    Message(text: "nhm yy lg ng haaaa", isSent: false, timestamp: "3:34 PM"),
    Message(text: "bc dea ng 😂😂😂", isSent: false, timestamp: "9:11 AM"),
  ];

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Back arrow icon
            color: Colors.white, // Set the icon color to white
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // Custom AppBar Title
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20, // Adjust the size of the CircleAvatar
              backgroundImage: AssetImage(
                  'assets/images/e-learning.png'), // Replace with your image
            ),
            SizedBox(
                width: 10), // Add some space between the image and the text
            Text(
              'User Name',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold), // Customize the text style
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade500,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Message",
                      hintStyle:
                          const TextStyle(color: Colors.blue), // Set hint text color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color:
                                Colors.blue), // Set border color when enabled
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            color:
                                Colors.blue), // Set border color when focused
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue.shade500,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isSent) ...[
          const CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage(
                'assets/images/e-learning.png'), // Replace with your image
          ),
          const SizedBox(width: 10),
        ],
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: message.isSent ? Colors.purple[200] : Colors.grey[300],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: const TextStyle(color: Colors.black),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  message.timestamp,
                  style: const TextStyle(color: Colors.black54, fontSize: 10.0),
                ),
              ),
            ],
          ),
        ),
        if (message.isSent) ...[
          const SizedBox(width: 10),
          const CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage(
                'assets/images/e-learning.png'), // Replace with sender image
          ),
        ],
      ],
    );
  }
}

class Message {
  final String text;
  final bool isSent;
  final String timestamp;

  Message({required this.text, required this.isSent, required this.timestamp});
}
