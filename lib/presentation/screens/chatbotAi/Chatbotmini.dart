import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_care/data/storage_service.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _speechReady = false;
  bool _isListening = false;

  bool _sending = false;
  final List<_ChatMsg> _messages = [];

  @override
  void initState() {
    super.initState();

    _initSpeech();
  }

  final List<_QuickOption> _options = const [
    _QuickOption(
      title: 'Thêm chi tiêu',
      subtitle: 'Ví dụ: "thêm chi tiêu 50k ăn sáng hôm nay"',
      template: 'thêm chi tiêu {số tiền} {nội dung} {ngày}',
    ),
  ];

  void _fillTemplate(String t) {
    _controller.text = t;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  Future<void> _sendTemplate(String t) async {
    _fillTemplate(t);
    await _send();
  }

  String get _chatbotUrl {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000/chatbot';
    }
    return 'http://127.0.0.1:3000/chatbot';
  }

  Future<String> _sendToChatbot(String message) async {
    final uri = Uri.parse(_chatbotUrl);

  final userInfo = StorageService().getUserInfo();
  final userId = userInfo?['id'];
    final res = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'userId': userId,
            'message': message,
          }),
        )
        .timeout(const Duration(seconds: 20));

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('HTTP ${res.statusCode}: ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['reply'] ?? '').toString();
  }

  Future<void> _initSpeech() async {
    final ok = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          if (mounted) setState(() => _isListening = false);
        }
      },
      onError: (_) {
        if (mounted) setState(() => _isListening = false);
      },
    );
    if (mounted) setState(() => _speechReady = ok);
  }

  Future<void> _toggleListen() async {
    if (!_speechReady) return;

    if (_isListening) {
      await _speech.stop();
      if (mounted) setState(() => _isListening = false);
      return;
    }

    if (mounted) setState(() => _isListening = true);

    await _speech.listen(
      localeId: 'vi_VN',
      listenMode: stt.ListenMode.dictation,
      onResult: (result) {
        _controller.text = result.recognizedWords;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      },
    );
  }

  void _scrollToBottom() {
    if (!_scroll.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() {
      _sending = true;
      _messages.add(_ChatMsg(isUser: true, text: text));
    });
    _controller.clear();
    _scrollToBottom();

    final typingIndex = _messages.length;
    setState(() {
      _messages.add(_ChatMsg(isUser: false, text: 'Đang trả lời...'));
    });
    _scrollToBottom();

    try {
      final reply = await _sendToChatbot(text);
      if (!mounted) return;

      setState(() {
        _messages[typingIndex] = _ChatMsg(isUser: false, text: reply);
        _sending = false;
      });
      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _messages[typingIndex] = _ChatMsg(
          isUser: false,
          text: 'Lỗi gọi chatbot: $e',
        );
        _sending = false;
      });
      _scrollToBottom();
    }
  }

  @override
  void dispose() {
    _speech.stop();
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white, 
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blueAccent),

        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/ai.gif',
                width: 34,
                height: 34,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text('ChatbotAi'),
          ],
        ),
      ),

      body: SafeArea(
        
        child: Column(
          children: [
            SizedBox(height: 0),
            Divider(height: 1),
            Expanded(
              child:
                  _messages.isEmpty
                      ? _WelcomeOptions(
                        options: _options,
                        onTapFill: _fillTemplate,
                        onTapSend: _sendTemplate,
                      )
                      : ListView.builder(
                        
                        controller: _scroll,
                        padding: const EdgeInsets.all(12),
                        itemCount: _messages.length,
                        itemBuilder: (context, i) {
                          final m = _messages[i];
                          return _Bubble(isUser: m.isUser, text: m.text);
                        },
                      ),
            ),

            const Divider(height: 1),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        minLines: 1,
                        maxLines: 4,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _send(),
                        decoration: InputDecoration(
                          hintText: 'Nhập tin nhắn...',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _toggleListen,
                      icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                      color: _speechReady ? Colors.blueAccent : Colors.grey,
                      tooltip:
                          _speechReady
                              ? (_isListening ? 'Dừng' : 'Nói để nhập')
                              : 'Chưa sẵn sàng',
                    ),
                    IconButton(
                      onPressed: _sending ? null : _send,
                      icon: const Icon(Icons.send),
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final bool isUser;
  final String text;

  const _Bubble({required this.isUser, required this.text});

  @override
  Widget build(BuildContext context) {
    final bg = isUser ? Colors.blueAccent : Colors.grey.shade200;
    final fg = isUser ? Colors.white : Colors.black87;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(text, style: TextStyle(color: fg)),
        ),
      ),
    );
  }
}

class _WelcomeOptions extends StatelessWidget {
  final List<_QuickOption> options;
  final void Function(String template) onTapFill;
  final Future<void> Function(String template) onTapSend;

  const _WelcomeOptions({
    required this.options,
    required this.onTapFill,
    required this.onTapSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(14),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Xin chào \nBạn có thể gõ hoặc nói theo cú pháp bên dưới:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  options.map((o) {
                    return ActionChip(
                      
                      label: Text(o.title),
                      labelStyle: const TextStyle(color: Colors.blueAccent),
                      onPressed: () => onTapFill(o.template),
                    );
                    
                  }).toList(),
            ),

            const SizedBox(height: 14),
            const Text(
              'Ví dụ lệnh',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            ...options.map(
              (o) => Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: Colors.lightBlue),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        o.subtitle,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blueAccent,
                                side: const BorderSide(
                                  color: Colors.blueAccent,
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => onTapFill(o.template),
                              child: const Text('Dán mẫu'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Mẹo voice : bấm mic và nói giống ví dụ, ví dụ: "thêm chi tiêu 50 nghìn ăn sáng hôm nay".',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMsg {
  final bool isUser;
  final String text;
  _ChatMsg({required this.isUser, required this.text});
}

class _QuickOption {
  final String title;
  final String subtitle;
  final String template;
  const _QuickOption({
    required this.title,
    required this.subtitle,
    required this.template,
  });
}
