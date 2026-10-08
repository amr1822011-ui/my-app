import 'package:flutter/material.dart';

void main() {
  runApp(const DailyApp());
}

class DailyApp extends StatelessWidget {
  const DailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'التشخيص اليومي',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int chatCount = 0;
  int videoCount = 0;
  int gamesCount = 0;

  final List<String> tips = [
    "💡 فتحك للتطبيقات باستمرار بيشتت تسلسل تفكيرك.. جرب تحدي '45 دقيقة بدون شاشة' عشان ترجع لقمة تركيزك.",
    "🚀 طبق قاعدة الـ 3 ثواني: قبل ما تفتح أي تطبيق، اسأل نفسك: 'أنا داخل أعمل إيه بالظبط؟' هتفرّق معاك جداً.",
    "🧠 عقلك محتاج وقت 'فراغ' عشان يبتكر.. اترك الموبايل بعيداً لمدة 10 دقائق بدون ما تعمل أي حاجة وراقب أفكارك.",
    "⚡ الإنتاجية مش في كثرة الملاحظات، بل في إنهاء مهمة واحدة رئيسية بتركيز كامل قبل الانتقال للثانية.",
    "🔋 صحتك الذهنية أهم من متابعة كل جديد؛ حدد أوقات ثابته لتفقد الإشعارات بدلاً من الاستجابة لها فوراً."
  ];

  int currentTipIndex = 0;

  void _nextTip() {
    setState(() {
      currentTipIndex = (currentTipIndex + 1) % tips.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text('لوحة التشخيص اليومي'),
        centerTitle: true,
        backgroundColor: const Color(0xFF161B22),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // كارت النصيحة
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF161B22),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.cyan, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '💡 نصيحة التشخيص اليومي',
                    style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tips[currentTipIndex],
                    style: const TextStyle(fontSize: 15, color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _nextTip,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                    child: const Text('نصيحة جديدة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              '📊 نشاط فتح التطبيقات اليوم:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),

            // كروت العدادات
            _buildCard('تطبيقات المحادثات', '💬', chatCount, () {
              setState(() => chatCount++);
            }),
            _buildCard('تطبيقات الفيديوهات', '🎬', videoCount, () {
              setState(() => videoCount++);
            }),
            _buildCard('الألعاب والترفيه', '🎮', gamesCount, () {
              setState(() => gamesCount++);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String emoji, int count, VoidCallback onAdd) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text('تم الفتح: $count مرة', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          TextButton(
            onPressed: onAdd,
            child: const Text('+ سجل فتح', style: TextStyle(color: Colors.cyan)),
          ),
        ],
      ),
    );
  }
}
