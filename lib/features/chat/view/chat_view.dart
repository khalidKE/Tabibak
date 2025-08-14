import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadMockMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _loadMockMessages() {
    _messages.addAll([
      ChatMessage(
        text: 'Hello! How can I help you today?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        senderName: 'Dr. Sarah Ahmed',
        senderAvatar: 'SA',
      ),
      ChatMessage(
        text: 'Hi Doctor, I have been experiencing headaches for the past few days.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
        senderName: 'You',
        senderAvatar: 'Me',
      ),
      ChatMessage(
        text: 'I understand. Can you tell me more about the headaches? When do they occur?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
        senderName: 'Dr. Sarah Ahmed',
        senderAvatar: 'SA',
      ),
      ChatMessage(
        text: 'They usually start in the morning and get worse throughout the day.',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        senderName: 'You',
        senderAvatar: 'Me',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsApp.kPrimaryColor,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: ColorsApp.kWhiteColor.withOpacity(0.2),
              child: Text(
                'SA',
                style: GoogleFonts.montserrat(
                  color: ColorsApp.kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Sarah Ahmed',
                    style: GoogleFonts.montserrat(
                      color: ColorsApp.kWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Cardiologist • Online',
                    style: GoogleFonts.montserrat(
                      color: ColorsApp.kWhiteColor.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsApp.kWhiteColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call, color: ColorsApp.kWhiteColor),
            onPressed: () => _startVideoCall(),
          ),
          IconButton(
            icon: const Icon(Icons.call, color: ColorsApp.kWhiteColor),
            onPressed: () => _startVoiceCall(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildChatMessages(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      reverse: true,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[_messages.length - 1 - index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: ColorsApp.kPrimaryColor.withOpacity(0.2),
              child: Text(
                message.senderAvatar,
                style: GoogleFonts.montserrat(
                  color: ColorsApp.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isMe ? ColorsApp.kPrimaryColor : ColorsApp.kWhiteColor,
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomLeft: message.isMe ? const Radius.circular(20) : const Radius.circular(5),
                  bottomRight: message.isMe ? const Radius.circular(5) : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: message.isMe ? ColorsApp.kWhiteColor : ColorsApp.kTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      color: message.isMe 
                          ? ColorsApp.kWhiteColor.withOpacity(0.7)
                          : ColorsApp.kSecondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: ColorsApp.kAccentColor.withOpacity(0.2),
              child: Text(
                message.senderAvatar,
                style: GoogleFonts.montserrat(
                  color: ColorsApp.kAccentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsApp.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.attach_file,
                color: ColorsApp.kSecondaryTextColor,
              ),
              onPressed: () => _attachFile(),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsApp.kBackgroundColor,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: ColorsApp.kLightGreyColor),
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: ColorsApp.kSecondaryTextColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isTyping = value.isNotEmpty;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: _isTyping ? ColorsApp.kPrimaryColor : ColorsApp.kLightGreyColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  _isTyping ? Icons.send : Icons.mic,
                  color: _isTyping ? ColorsApp.kWhiteColor : ColorsApp.kSecondaryTextColor,
                ),
                onPressed: _isTyping ? _sendMessage : _startVoiceMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now';
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isMe: true,
            timestamp: DateTime.now(),
            senderName: 'You',
            senderAvatar: 'Me',
          ),
        );
        _isTyping = false;
      });
      _messageController.clear();

      // Simulate doctor response
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _messages.add(
              ChatMessage(
                text: 'Thank you for the information. I\'ll review this and get back to you shortly.',
                isMe: false,
                timestamp: DateTime.now(),
                senderName: 'Dr. Sarah Ahmed',
                senderAvatar: 'SA',
              ),
            );
          });
        }
      });
    }
  }

  void _startVoiceMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice message functionality coming soon'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _attachFile() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Attach File',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsApp.kTextColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption(
                  Icons.camera_alt,
                  'Camera',
                  () => _takePhoto(),
                ),
                _buildAttachmentOption(
                  Icons.photo_library,
                  'Gallery',
                  () => _pickFromGallery(),
                ),
                _buildAttachmentOption(
                  Icons.description,
                  'Document',
                  () => _pickDocument(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorsApp.kPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: ColorsApp.kPrimaryColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorsApp.kTextColor,
            ),
          ),
        ],
      ),
    );
  }

  void _takePhoto() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Camera functionality coming soon'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _pickFromGallery() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery functionality coming soon'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _pickDocument() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document picker functionality coming soon'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _startVideoCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Video call functionality coming soon'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }

  void _startVoiceCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice call functionality coming soon'),
        backgroundColor: ColorsApp.kInfoColor,
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final String senderName;
  final String senderAvatar;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
    required this.senderName,
    required this.senderAvatar,
  });
}
