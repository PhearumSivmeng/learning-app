import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/chat_model.dart';
import 'package:demo/data/models/user_model.dart';
import 'package:demo/data/services/db_service.dart';
import 'package:demo/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatSlotScreen extends StatefulWidget {
  final String roomId;

  // Constructor with parameters
  const ChatSlotScreen({super.key, required this.roomId});
  @override
  _ChatSlotScreenState createState() => _ChatSlotScreenState();
}

class _ChatSlotScreenState extends State<ChatSlotScreen> {
  final client = http.Client();
  ChatModel? chat;
  int currentUserId = 0;
  Helper helper = Helper();
  final TextEditingController _message = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessager();
    listenForEvents();
  }

  void listenForEvents() {
    // PusherService pusherService = PusherService();
    // pusherService.channel.bind("my-event", (PusherEvent? event) {
    //   if (event != null) {
    //     print("Received event: ${event.data}");
    //     setState(() {});
    //   }
    // });
  }

  void getMessager() async {
    final apiClient = ApiClient(client: client);
    final db = await DB.instance.db;
    final result = await db.query(UserModel.tableName);
    final token = result[0]["token"];
    currentUserId = int.parse(helper.decryptHelper(result[0]['id'].toString()));

    // print(helper.decryptHelper(result[0]['id'].toString()));
    // currentUserId = result[0]['id'];
    try {
      final response = await apiClient
          .onGetMessager(arg: {"token": token, "room_id": widget.roomId});
      if (response.status == "success") {
        setState(() {
          chat = response.records;
        });
      } else {
        print("Get Messagers Failed: ${response.msg}");
      }
    } catch (e) {
      print("Error fetching messagers: $e");
    }
  }

  void sendMessager() async {
    final apiClient = ApiClient(client: client);
    final db = await DB.instance.db;
    final result = await db.query(UserModel.tableName);
    final token = result[0]["token"];
    currentUserId = int.parse(helper.decryptHelper(result[0]['id'].toString()));

    // print(helper.decryptHelper(result[0]['id'].toString()));
    // currentUserId = result[0]['id'];
    try {
      final response = await apiClient.onSendMessager(arg: {
        "token": token,
        "room_id": widget.roomId,
        "partner_id": widget.roomId.replaceFirst(currentUserId.toString(), ''),
        "type": "text",
        "content": _message.value.text
      });

      if (response.status == "success") {
        setState(() {
          MessageModel newMessage = MessageModel(
            id: -1,
            senderId: 3,
            isRead: "Yes",
            date:
                DateTime.now().toString(), // Capture the current date and time
            content: _message.value.text,
            attachments: null,
          );
          chat!.records.add(newMessage);
        });
      } else {
        print("Get Messagers Failed: ${response.msg}");
      }
    } catch (e) {
      print("Error fetching messagers: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: (chat?.partnerImage.isNotEmpty ?? false)
                    ? NetworkImage(
                        chat!.partnerImage.replaceAll("localhost", "10.0.2.2"))
                    : const AssetImage("assets/images/profile-picture.png")
                        as ImageProvider,
              ),
              const SizedBox(width: 20),
              Text(
                chat?.partnerName ?? "Unknown",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: chat == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: chat!.records.length,
                    itemBuilder: (context, index) {
                      final message = chat!.records[index];
                      final isCurrentUser = message.senderId == currentUserId;

                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color:
                                isCurrentUser ? Colors.blue : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message.content,
                            style: TextStyle(
                                color: isCurrentUser
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Text input box
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _message,
                          decoration: const InputDecoration(
                            hintText: "Aa",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // print("Photo icon clicked");
                        },
                        child: const Icon(Icons.photo, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          sendMessager();
                        },
                        child: const Icon(Icons.send, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
