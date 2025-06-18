import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class HeartAIChat extends StatefulWidget {
  const HeartAIChat({super.key});

  @override
  State<HeartAIChat> createState() => _HeartAIChatState();
}

class _HeartAIChatState extends State<HeartAIChat> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  
  final String apiKey = 'AIzaSyAnf-QHazh4RaXvtveIcBCd-qeDaUwaF9U';
  final String apiUrl = 'https://gemini-heart-api.onrender.com/ask';
  final int maxRetries = 3;
  final Duration timeout = const Duration(seconds: 30);

  final headers = {
    'Content-Type': 'application/json',
  };



  final List<SuggestionChip> _suggestions = [
    SuggestionChip(
      text: "Diet Plan",
      prompt: "What foods should I eat for a healthy heart?",
      icon: Icons.restaurant_menu,
    ),
    SuggestionChip(
      text: "Exercise",
      prompt: "What are the best exercises for heart health?",
      icon: Icons.fitness_center,
    ),
    SuggestionChip(
      text: "Symptoms",
      prompt: "What are common heart disease symptoms?",
      icon: Icons.medical_services,
    ),
    SuggestionChip(
      text: "Prevention",
      prompt: "How can I prevent heart disease?",
      icon: Icons.health_and_safety,
    ),
    SuggestionChip(
      text: "Risk Factors",
      prompt: "What are the major risk factors for heart disease?",
      icon: Icons.warning,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _addInitialBotMessage();
  }

  void _addInitialBotMessage() {
    setState(() {
      _messages.add(
        ChatMessage(
          text: "Hello! I'm your HeartCare AI Assistant. I can help you with:\n\n"
              "• Heart-healthy diet plans\n"
              "• Exercise recommendations\n"
              "• Lifestyle modifications\n"
              "• General heart health information\n\n"
              "How can I assist you today?",
          isUser: false,
        ),
      );
    });
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'question': text,
        }),
      ).timeout(timeout);

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String botResponse = data['response'] ?? 'I apologize, I was unable to process that request.';
        
        setState(() {
          _messages.add(ChatMessage(
            text: _formatResponse(botResponse),
            isUser: false,
          ));
        });
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in API call: $e');
      setState(() {
        _messages.add(ChatMessage(
          text: "I'm having trouble connecting to the service. Please try again in a moment.",
          isUser: false,
        ));
      });
    } finally {
      setState(() => _isLoading = false);
    }
    _scrollToBottom();
  }

  String _formatResponse(String response) {
    // Split the text into lines
    List<String> lines = response.split('\n');
    List<String> formattedLines = [];
    
    for (String line in lines) {
      // Handle headings (text followed by :)
      if (line.trim().endsWith(':')) {
        formattedLines.add('\n**${line.trim()}**\n');
      }
      // Handle bullet points
      else if (line.trim().startsWith('-') || line.trim().startsWith('*')) {
        formattedLines.add('• ${line.trim().substring(1).trim()}');
      }
      // Handle numbered points
      else if (RegExp(r'^\d+[\.\)]').hasMatch(line.trim())) {
        formattedLines.add('• ${line.replaceFirst(RegExp(r'^\d+[\.\)]'), '').trim()}');
      }
      // Keep other lines as is
      else {
        formattedLines.add(line);
      }
    }
    
    return formattedLines.join('\n')
        .replaceAll(RegExp(r'\n\n+'), '\n\n')
        .trim();
  }

  void _handleError() {
    setState(() {
      _messages.add(
        ChatMessage(
          text: "I'm having trouble connecting. Please check your internet connection and try again.",
          isUser: false,
        ),
      );
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HeartCare AI Assistant'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          _buildAIAssistantHeader(),
          _buildSuggestionChips(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return _buildTypingIndicator();
                }
                return _messages[index];
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildAIAssistantHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.pink.shade50,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite, color: Colors.pink, size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HeartCare AI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Your personal heart health assistant',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChips() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ActionChip(
              avatar: Icon(suggestion.icon, size: 18, color: Colors.pink),
              label: Text(suggestion.text),
              backgroundColor: Colors.pink.shade50,
              side: BorderSide(color: Colors.pink.shade100),
              onPressed: () => _sendMessage(suggestion.prompt),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText(
            'AI is typing...',
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.pink,
            ),
          ),
        ],
        isRepeatingAnimation: true,
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask about heart health...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onSubmitted: _isLoading ? null : _sendMessage,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _isLoading
                ? null
                : () => _sendMessage(_controller.text),
            backgroundColor: Colors.pink,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.pink.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.pink.shade900 : Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isUser) const CircleAvatar(
            backgroundColor: Colors.pink,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.favorite, color: Colors.pink, size: 20),
    );
  }
}

class SuggestionChip {
  final String text;
  final String prompt;
  final IconData icon;

  SuggestionChip({
    required this.text,
    required this.prompt,
    required this.icon,
  });
}
