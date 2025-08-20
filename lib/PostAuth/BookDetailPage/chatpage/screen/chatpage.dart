import 'package:bookcycle/Authentication/components/custom_textfield.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/chatModel.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/Model/messageModel.dart';
import 'package:bookcycle/PostAuth/BookDetailPage/chatpage/repository/chatrepo.dart';
import 'package:bookcycle/consts/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String personimagepath;
  final String personName;
  final String bookimagepath;
  final String booktitle;
  final String bookprice;
  final Chat chatdoc;

  ChatPage({
    super.key,
    required this.personimagepath,
    required this.personName,
    required this.bookimagepath,
    required this.booktitle,
    required this.bookprice,
    required this.chatdoc,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isempty = true;

  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String imageurl = dotenv.get('imagefetchurl');
    String bookimage = imageurl + widget.bookimagepath;
    String personimage = imageurl + widget.personimagepath;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.back, color: Colors.black)),
          const SizedBox(width: 5),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(personimage),
            onBackgroundImageError: (_, __) {},
          ),
          const SizedBox(width: 10),
          Text(widget.personName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        ]),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Colors.black))
        ],
      ),
      body: StreamBuilder<List<Message>>(
        stream: BookChatRepo().messageStream(widget.chatdoc.chatId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          final currentUserId = FirebaseAuth.instance.currentUser!.uid;


          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

          return SafeArea(
            child: Column(
              children: [

                Container(
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            bookimage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                            errorBuilder: (context, _, __) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.purple.shade50,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(widget.booktitle,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            const SizedBox(height: 5),
                            Text(widget.bookprice,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // Messages list
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final msg = data[data.length - 1 - index];

                      IconData statusIcon;
                      if (msg.status == 'sending') {
                        statusIcon = Icons.access_time;
                      } else if (msg.status == 'sent') {
                        statusIcon = Icons.check;
                      } else {
                        statusIcon = Icons.error;
                      }

                      return Row(
                        mainAxisAlignment: msg.senderId == currentUserId
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints:
                            const BoxConstraints(minWidth: 0, maxWidth: 300),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: msg.senderId == currentUserId
                                    ? Colors.blue[200]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(child: Text(msg.text)),
                                  const SizedBox(width: 7),
                                  if (msg.timestamp != null)
                                    Text(
                                      DateFormat.jm()
                                          .format(msg.timestamp!.toDate()),
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.grey.shade700),
                                    ),
                                  if (msg.senderId == currentUserId) ...[
                                    const SizedBox(width: 4),
                                    Icon(statusIcon,
                                        size: 14, color: Colors.black54),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Input bar
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          onchanged: (_) {
                            setState(() {
                              isempty = controller.text.isEmpty;
                            });
                          },
                          verticalpadding: 5,
                          hintext: 'Type a message',
                          controller: controller,
                          validator: fieldValidator,
                          color: Colors.white,
                          borderColor: Colors.black,
                          generalboderColor: Colors.black12,
                          hintextcolor: Colors.black54,
                          textColor: Colors.black,
                          borderRadius: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (!isempty)
                        GestureDetector(
                          onTap: () {
                            BookChatRepo().sendMessage(
                              text: controller.text,
                              chatId: widget.chatdoc.chatId,
                            );
                            controller.clear();
                            setState(() => isempty = true);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                                child: Icon(Icons.send, color: Colors.white)),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
