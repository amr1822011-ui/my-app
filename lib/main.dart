<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>التشخيص اليومي الذكي</title>
  <style>
    :root {
      --bg-gradient: linear-gradient(135deg, #0d1117, #161b22, #0d1117);
      --card-glass: rgba(22, 27, 34, 0.65);
      --card-border: rgba(56, 189, 248, 0.2);
      --neon-blue: #38bdf8;
      --neon-purple: #c084fc;
      --text-main: #f0f6fc;
      --text-sub: #8b949e;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: system-ui, -apple-system, sans-serif;
      -webkit-tap-highlight-color: transparent;
    }

    body {
      background: var(--bg-gradient);
      color: var(--text-main);
      padding: 20px 15px;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    /* أنيميشن الظهور التدريجي */
    .animate-fade-up {
      animation: fadeUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
      opacity: 0;
      transform: translateY(20px);
    }

    @keyframes fadeUp {
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* الهيدر */
    header {
      text-align: center;
      margin-top: 10px;
    }

    header h1 {
      font-size: 1.5rem;
      background: linear-gradient(90deg, var(--neon-blue), var(--neon-purple));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin-bottom: 5px;
    }

    header p {
      font-size: 0.85rem;
      color: var(--text-sub);
    }

    /* كارت النصيحة اليومية المتوهج */
    .diagnosis-card {
      background: var(--card-glass);
      border: 1px solid var(--card-border);
      border-radius: 20px;
      padding: 20px;
      backdrop-filter: blur(15px);
      box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
      position: relative;
      overflow: hidden;
      animation-delay: 0.2s;
    }

    .diagnosis-card::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, var(--card-border) 0%, transparent 60%);
      animation: pulseGlow 6s infinite alternate ease-in-out;
      pointer-events: none;
    }

    @keyframes pulseGlow {
      0% { transform: scale(0.8); opacity: 0.3; }
      100% { transform: scale(1.2); opacity: 0.7; }
    }

    .badge {
      display: inline-block;
      background: rgba(56, 189, 248, 0.15);
      color: var(--neon-blue);
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: bold;
      margin-bottom: 12px;
      border: 1px solid rgba(56, 189, 248, 0.3);
    }

    .tip-text {
      font-size: 1rem;
      line-height: 1.6;
      margin-bottom: 15px;
      min-height: 70px;
      transition: opacity 0.3s ease, transform 0.3s ease;
    }

    .refresh-btn {
      background: linear-gradient(135deg, var(--neon-blue), var(--neon-purple));
      border: none;
      color: #000;
      font-weight: bold;
      padding: 10px 18px;
      border-radius: 12px;
      font-size: 0.85rem;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 8px;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .refresh-btn:active {
      transform: scale(0.92);
    }

    /* قسم العدادات ومتابعة النشاط */
    .stats-section {
      animation-delay: 0.4s;
    }

    .section-title {
      font-size: 1.1rem;
      margin-bottom: 15px;
      color: var(--text-main);
    }

    .app-item {
      background: var(--card-glass);
      border: 1px solid rgba(255, 255, 255, 0.05);
      border-radius: 16px;
      padding: 15px;
      margin-bottom: 12px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      backdrop-filter: blur(10px);
      transition: transform 0.2s ease;
    }

    .app-item:active {
      transform: scale(0.98);
    }

    .app-info {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .app-icon {
      width: 40px;
      height: 40px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.2rem;
      background: rgba(255, 255, 255, 0.05);
    }

    .app-name {
      font-size: 0.95rem;
      font-weight: bold;
    }

    .app-count {
      font-size: 0.8rem;
      color: var(--text-sub);
    }

    .add-btn {
      background: rgba(56, 189, 248, 0.1);
      border: 1px solid var(--neon-blue);
      color: var(--neon-blue);
      padding: 8px 14px;
      border-radius: 10px;
      font-size: 0.8rem;
      font-weight: bold;
      cursor: pointer;
      transition: all 0.2s ease;
    }

    .add-btn:active {
      background: var(--neon-blue);
      color: #000;
      transform: scale(0.9);
    }
  </style>
</head>
<body>

  <!-- الهيدر -->
  <header class="animate-fade-up">
    <h1>لوحة التشخيص اليومي</h1>
    <p>تحليل نشاطك ونصائح ذكية مخصصة</p>
  </header>

  <!-- كارت النصيحة اليومية -->
  <div class="diagnosis-card animate-fade-up">
    <div class="badge">💡 نصيحة التشخيص اليومي</div>
    <div class="tip-text" id="tipText">
      جاري تحميل نصيحة اليوم المبتكرة...
    </div>
    <button class="refresh-btn" onclick="generateNewTip()">
      <span>🔄 نصيحة جديدة</span>
    </button>
  </div>

  <!-- قسم متابعة فتح التطبيقات والنشاط -->
  <div class="stats-section animate-fade-up">
    <div class="section-title">📊 نشاط فتح التطبيقات اليوم:</div>

    <div class="app-item">
      <div class="app-info">
        <div class="app-icon">💬</div>
        <div>
          <div class="app-name">تطبيقات المحادثات</div>
          <div class="app-count" id="count1">تم الفتح: 0 مرة</div>
        </div>
      </div>
      <button class="add-btn" onclick="increment('count1')">+ سجل فتح</button>
    </div>

    <div class="app-item">
      <div class="app-info">
        <div class="app-icon">🎬</div>
        <div>
          <div class="app-name">تطبيقات الفيديوهات</div>
          <div class="app-count" id="count2">تم الفتح: 0 مرة</div>
        </div>
      </div>
      <button class="add-btn" onclick="increment('count2')">+ سجل فتح</button>
    </div>

    <div class="app-item">
      <div class="app-info">
        <div class="app-icon">🎮</div>
        <div>
          <div class="app-name">الألعاب والترفيه</div>
          <div class="app-count" id="count3">تم الفتح: 0 مرة</div>
        </div>
      </div>
      <button class="add-btn" onclick="increment('count3')">+ سجل فتح</button>
    </div>
  </div>

  <script>
    // مصفوفة النصائح المبتكرة
    const tips = [
      "💡 فتحك للتطبيقات باستمرار بيشتت تسلسل تفكيرك.. جرب تحدي '45 دقيقة بدون شاشة' عشان ترجع لقمة تركيزك.",
      "🚀 طبق قاعدة الـ 3 ثواني: قبل ما تفتح أي تطبيق، اسأل نفسك: 'أنا داخل أعمل إيه بالظبط؟' هتفرّق معاك جداً.",
      "🧠 عقلك محتاج وقت 'فراغ' عشان يبتكر.. اترك الموبايل بعيداً لمدة 10 دقائق بدون ما تعمل أي حاجة وراقب أفكارك.",
      "⚡ الإنتاجية مش في كثرة الملاحظات، بل في إنهاء مهمة واحدة رئيسية بتركيز كامل قبل الانتقال للثانية.",
      "🔋 صحتك الذهنية أهم من متابعة كل جديد؛ حدد أوقات ثابته لتفقد الإشعارات بدلاً من الاستجابة لها فوراً."
    ];

    let currentTipIndex = 0;

    function generateNewTip() {
      const tipElement = document.getElementById('tipText');
      
      // أنيميشن الاختفاء والظهور عند التغيير
      tipElement.style.opacity = '0';
      tipElement.style.transform = 'translateY(-10px)';

      setTimeout(() => {
        currentTipIndex = (currentTipIndex + 1) % tips.length;
        tipElement.innerText = tips[currentTipIndex];
        tipElement.style.opacity = '1';
        tipElement.style.transform = 'translateY(0)';
      }, 300);
    }

    // العدادات التفاعلية
    const counts = { count1: 0, count2: 0, count3: 0 };

    function increment(id) {
      counts[id]++;
      const el = document.getElementById(id);
      el.innerText = `تم الفتح: ${counts[id]} مرة`;
      
      // أنيميشن اهتزاز خفيف للرقم
      el.style.color = '#38bdf8';
      setTimeout(() => {
        el.style.color = '#8b949e';
      }, 300);
    }

    // تشغيل أول نصيحة تلقائياً
    window.onload = () => {
      document.getElementById('tipText').innerText = tips[0];
    };
  </script>
</body>
</html>
