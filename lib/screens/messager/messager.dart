import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/partner_model.dart';
import 'package:demo/data/models/user_active_model.dart';
import 'package:demo/data/models/user_model.dart';
import 'package:demo/data/services/db_service.dart';
import 'package:demo/screens/chatslot/chatslot.dart';
import 'package:demo/widget/chatItem_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagerScreen extends StatefulWidget {
  const MessagerScreen({super.key});

  @override
  _MessagerScreenState createState() => _MessagerScreenState();
}

class _MessagerScreenState extends State<MessagerScreen> {
  final List<bool> isSelected = [true, false];
  List<PartnerModel> chatList = [];
  List<UserActiveModel> activeUsers = [];
  final client = http.Client();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessagers();
    getActiveUsers();
  }

  Future<void> getMessagers() async {
    final apiClient = ApiClient(client: client);
    final db = await DB.instance.db;
    final result = await db.query(UserModel.tableName);
    final token = result[0]["token"];
    try {
      final response = await apiClient.onGetMessagers(arg: {"token": token});
      if (response.status == "success") {
        setState(() {
          chatList = response.records ?? [];
        });
      } else {
        print("Get Messagers Failed: ${response.msg}");
      }
    } catch (e) {
      print("Error fetching messagers: $e");
    }
  }

  Future<void> getActiveUsers() async {
    final apiClient = ApiClient(client: client);
    final db = await DB.instance.db;
    final result = await db.query(UserModel.tableName);
    final token = result[0]["token"];
    try {
      final response = await apiClient.onGetUsersActive(arg: {"token": token});
      if (response.status == "success") {
        print("Active Users: ${response.records}");
        setState(() {
          activeUsers = response.records ?? [];
        });
      } else {
        print("Get Active Users Failed: ${response.msg}");
      }
    } catch (e) {
      print("Error fetching active users: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activeUsers.length,
              itemBuilder: (context, index) {
                final user = activeUsers[index];
                return Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                user.profile != null && user.profile!.isNotEmpty
                                    ? NetworkImage(user.profile!
                                        .replaceAll("localhost", "10.0.2.2"))
                                    : const AssetImage(
                                            "assets/images/profile-picture.png")
                                        as ImageProvider,
                          ),
                          // Green dot indicator for active users
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: chatList.isEmpty
                ? const Center(child: Text("No chats available"))
                : ListView.builder(
                    itemCount: chatList.length, // Number of chats
                    itemBuilder: (context, index) {
                      final chat = chatList[index];
                      return ChatListItem(
                        name: chat.partnerName ?? 'Unknown',
                        lastMessage: chat.content ?? 'No messages',
                        time: chat.date ?? '',
                        imageUrl: chat.partnerProfile
                            .replaceAll("localhost", "10.0.2.2"),
                        unreadCount: chat.unreadCount ?? 0,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatSlotScreen(
                                    roomId: chat.roomId.toString())),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
