import 'package:flutter/material.dart';
import 'package:edu_p4c/widgets/bottom_nav_bar.dart';
import 'package:edu_p4c/screens/lesson_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lesson {
  final String title;
  final String imagePath;
  final String videoUrl;
  final String contentText;
  final String category; // Örn: "beginner", "intermediate", "advanced"

  Lesson({
    required this.title,
    required this.imagePath,
    required this.videoUrl,
    required this.contentText,
    required this.category,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;

  // Tüm dersler (örnek veriler)
  final List<Lesson> allLessons = [
    // Beginner Level
    Lesson(
      title: 'Philosophy of Being',
      imagePath: 'assets/lesson1.png',
      videoUrl: 'https://www.youtube.com/watch?v=UHwVyplU3Pg',
      contentText:
          'The philosophy of being questions what it means "to be." Every object, living thing, or thought has its own unique life. Perhaps everything in the world tells a different story in your eyes! 🌍✨\n\n'
          'Let\'s think simply: A tree, a flower, or even a toy gives us a message with its own existence. The value of everything is hidden in its existence. 🤔💭',
      category: 'beginner',
    ),
    Lesson(
      title: 'Understanding Good and Evil',
      imagePath: 'assets/kids_help_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=GmP7qjKdNB0&t=28s',
      contentText:
          'Good and evil are two opposite forces that we constantly encounter in our lives. 🍀😈 We all try to find the truth by listening to our hearts when making choices in our daily lives.\n\n'
          'Goodness brings love, charity, and friendship; evil brings sadness and confusion. In its simplest form, being right is feeding the light within us! ❤️👍',
      category: 'beginner',
    ),
    Lesson(
      title: 'Philosophy of Morality',
      imagePath: 'assets/lesson3.png',
      videoUrl: 'https://www.youtube.com/watch?v=nyTmeb4vFqE',
      contentText:
          'Morality is the set of rules that tells us how to treat each other. 🤝😊 The philosophy of morality questions what is right and what is wrong; we can do great good with our small actions.\n\n'
          'Every step is an expression of the goodness within us. Remember, the goodness in your heart beautifies the world! ✨🌟',
      category: 'beginner',
    ),
    Lesson(
      title: 'Philosophy of Art',
      imagePath: 'assets/kids_art_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=HoXyw909Qu0',
      contentText:
          'Art is the most fun way to express our feelings with colors, sounds, and shapes. 🎨😄 The philosophy of art aims to discover the meaning behind every brushstroke, every note.\n\n'
          'Every line tells a feeling, every color tells a story. Come on, unleash your imagination and be captivated by the magic of art! 🌈🖌️',
      category: 'beginner',
    ),
    Lesson(
      title: 'Our Responsibilities',
      imagePath: 'assets/kids_clean_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=iVs5GkGYwMc',
      contentText:
          'We all have small but important tasks in our lives. 🌟👐 Our responsibilities are an expression of our love for our family, friends, and nature.\n\n'
          'Small steps create big changes; don\'t forget to be sensitive to your environment and the world! 🌍💪',
      category: 'beginner',
    ),
    Lesson(
      title: 'Dream World',
      imagePath: 'assets/kids_dream_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=09TRoxgVPjs',
      contentText:
          'Imagination is the most colorful window of your soul. 🌈💭 The dream world is a place where you can get away from reality and explore endless possibilities.\n\n'
          'Whether it\'s flying cars or talking animals... Anything is possible! Are you ready to write your own fairy tale? 🚀✨',
      category: 'beginner',
    ),
    Lesson(
      title: 'Philosophy of Education',
      imagePath: 'assets/kids_edu_lessons.png',
      videoUrl: 'https://www.youtube.com/watch?v=kHrbtjI4uMQ',
      contentText:
          'Education is a fun and continuous journey of learning. 📚🌱 Beyond textbooks, we can also gain knowledge through experience and discovery.\n\n'
          'Learning something new every day helps us understand the world better. Have fun while learning, explore! 🤓🌟',
      category: 'beginner',
    ),
    Lesson(
      title: 'Introduction to Philosophy',
      imagePath: 'assets/kids_enjoy_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=eMviXkkd-T4',
      contentText:
          'Philosophy is a journey that starts with the question "Why?" and leads to deep thoughts. 💡🤔 Although not every question has an answer, asking takes us on the path to wisdom.\n\n'
          'How about starting with simple questions and discovering the secrets of the universe? 🌌✨',
      category: 'beginner',
    ),
    Lesson(
      title: 'Freedom and Will',
      imagePath: 'assets/kids_freedom_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=JHE08GSThZs',
      contentText:
          'Freedom is the ability to make your own choices; will is the power to implement these choices. 🕊️🌟\n\n'
          'Being able to think freely and take responsibility makes life more meaningful. Be brave to chart your own path! 💫🤗',
      category: 'beginner',
    ),
    Lesson(
      title: 'Philosophy of Time',
      imagePath: 'assets/kids_time_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=R3tbVHlsKhs',
      contentText:
          'Time is like a flowing river; every moment is precious. ⏳🕰️\n\n'
          'The philosophy of time questions how the past, present, and future are intertwined. Focus on the now, live in the moment, and make the most of every minute! 🌟💖',
      category: 'beginner',
    ),

    // Intermediate Level
    Lesson(
      title: 'Philosophy of Art',
      imagePath: 'assets/art_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=MF8kz-mTIp4',
      contentText:
          'The philosophy of art delves into the depths of aesthetics and creativity, questioning how art touches the human soul. 🎨🤔\n\n'
          'Discovering the meanings behind colors, forms, and sounds illuminates the inner journey of emotions and thoughts. Art expresses the complexity of life in a simple language. 🌟🖼️',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Philosophy of Happiness',
      imagePath: 'assets/happines_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=YaDvRdLMkHs&t=347s',
      contentText:
          'Happiness is a deep and lasting quest for peace beyond the joy on the surface. 😊💖\n\n'
          'The philosophy of happiness advocates a life understanding that can be achieved with inner balance and awareness, beyond temporary pleasures. Discover yourself and open the doors to true happiness! 🌼🤍',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Philosophy of Existence',
      imagePath: 'assets/existence_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=c9ULvz_NLlk',
      contentText:
          'The philosophy of existence deeply questions the place of man in the universe and the meaning of life. 🌌🤔\n\n'
          'This bridge between the transience of life and the infinity of the universe offers new perspectives on existence. This journey is an important discovery that will enrich your soul. ✨🧠',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Philosophy of Identity',
      imagePath: 'assets/identity_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=trqDnLNRuSc',
      contentText:
          'The philosophy of identity deals with the individual\'s search for an answer to the question "Who am I?". 👤🔍\n\n'
          'Personal values, past experiences, and social environment are the building blocks of our identity. The process of getting to know yourself is a deep and meaningful journey of discovery. 🌟💭',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Knowledge and Wisdom',
      imagePath: 'assets/knowledge_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=r_Y3utIeTPg',
      contentText:
          'While knowledge represents the first step in understanding the world, wisdom questions how we integrate this knowledge into life. 📘🧠\n\n'
          'Constantly asking questions and thinking critically while learning helps us build a solid bridge between knowledge and wisdom. 🔍✨',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Understanding Languages',
      imagePath: 'assets/language_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=zmwgmt7wcv8',
      contentText:
          'Understanding the structure and functioning of languages means opening the doors to different cultures. 🗣️🌍\n\n'
          'Each language offers a unique logic and aesthetic; it expands the limits of the human mind through words. Discover new worlds with the power of language! 📜🤓',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Justice and Law',
      imagePath: 'assets/law_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=r_UfYY7aWKo',
      contentText:
          'Justice and law play a fundamental role in society\'s quest for order and equality. ⚖️🏛️\n\n'
          'Not only laws but also human dignity and ethical values are the building blocks of justice. Take a deep look at these subtleties of the social contract and walk in the footsteps of justice! 💭🌟',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Philosophy of Technology',
      imagePath: 'assets/technology_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=oX-IoIB9QCg',
      contentText:
          'The philosophy of technology questions the transformation of modern life and the innovations it brings to ethical, existential questions. 💻🤖\n\n'
          'It is becoming increasingly important to redefine the meaning of being human amidst the opportunities and challenges offered by the digital world. Think smart and critically! 🌐✨',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Perception of Reality',
      imagePath: 'assets/realty_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=IV-8YsyghbU',
      contentText:
          'The perception of reality explores the multi-layered nature of the universe beyond the information we acquire through our senses. 👁️🌐\n\n'
          'Questioning how different perspectives lead us to interpret the world differently broadens our mental horizons. Dive into thought! 🤔💡',
      category: 'intermediate',
    ),
    Lesson(
      title: 'Our Responsibilities',
      imagePath: 'assets/responsibility_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=AYkhlXronNk',
      contentText:
          'Responsibility is the expression of the duties we undertake both individually and socially. 🌟🤝\n\n'
          'This responsibility, nourished by ethical values, requires us to be sensitive to both ourselves and our environment. Make conscious choices that deepen the meaning of life! 💬✨',
      category: 'intermediate',
    ),

    // Advanced Level
    Lesson(
      title: 'Philosophy of Art',
      imagePath: 'assets/art_adult_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=T6EOVCYx7mY',
      contentText:
          'The philosophy of art questions the subtle interpretations of aesthetic experience and the ontological dimension of the creative process. 🎨🤔\n\n'
          'Each work of art not only offers a sensory pleasure but also creates a symbolic language that reflects the complexity of existence. This approach, which invites the viewer to different layers of consciousness, makes art a universal form of expression. 🌌📚',
      category: 'advanced',
    ),
    Lesson(
      title: 'Freedom and Will',
      imagePath: 'assets/freedom_adult_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=ANlPOFwgimc',
      contentText:
          'Freedom and will are a profound philosophical debate that questions the complex interaction between determinism and individual autonomy. 🕊️💭\n\n'
          'Free will, one of the fundamental paradoxes of human existence, is shaped by both personal choices and social structures. Exploring the fine details of this paradox with critical thinking plays a key role in understanding the essence of existence. 🔍✨',
      category: 'advanced',
    ),
    Lesson(
      title: 'Knowledge and Wisdom',
      imagePath: 'assets/knowledge_adult_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=6SQDD5E0jZA&t=289s',
      contentText:
          'While knowledge represents the beginning of an epistemological quest, wisdom deeply questions the ethical and practical reflections of this knowledge. 📚🧠\n\n'
          'The question "What is truth?" reveals the subtle bridges built between reason and intuition. Critical inquiry, one of the cornerstones of modern thought, is indispensable in the pursuit of wisdom. 🤓🌟',
      category: 'advanced',
    ),
    Lesson(
      title: 'Politics',
      imagePath: 'assets/political_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=AOXl0Ll_t9s',
      contentText:
          'Politics is a complex philosophical discussion that examines power relations, the pursuit of justice, and the dynamics of social order. 🏛️⚖️\n\n'
          'This delicate balance between individual freedom and collective order is addressed with historical and structural perspectives, shedding light on the fundamental problems of modern societies. Critical analysis forms the basis of political philosophy. 💡📜',
      category: 'advanced',
    ),
    Lesson(
      title: 'Philosophy of Science',
      imagePath: 'assets/science_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=wkRjj4r4sJc',
      contentText:
          'The philosophy of science is a comprehensive discipline that questions the laws of nature and the limits of human knowledge. 🔬🌌\n\n'
          'The evolution in scientific paradigms is discussed together with methodological and ontological questions; grasping the multidimensionality of reality requires a deep philosophical inquiry. A critical perspective is the cornerstone of scientific thought. 🤔📖',
      category: 'advanced',
    ),
    Lesson(
      title: 'About Languages',
      imagePath: 'assets/language_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=zmwgmt7wcv8',
      contentText:
          'Thoughts on languages offer a sophisticated philosophical analysis that questions the building blocks of language, the construction of meaning, and the limits of communication. 🗣️📜\n\n'
          'Language, which has a decisive influence on both individual consciousness and social memory, reveals its universality and subjective interpretations when examined with semiotic approaches. Analyze in depth! 🤓🌟',
      category: 'advanced',
    ),
    Lesson(
      title: 'About Religions',
      imagePath: 'assets/religion_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=BjEl46vsQNM',
      contentText:
          'Philosophical approaches to religions meticulously address the ontological and ethical dimensions of belief systems. 🕌✝️\n\n'
          'While the metaphorical narratives of different religions meet on a common ground in the human existential quest, theological inquiries open new horizons at the intersection of faith and reason. Enrich your thoughts! 🌌📚',
      category: 'advanced',
    ),
    Lesson(
      title: 'Metaphysics Philosophy',
      imagePath: 'assets/metaphysic_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=FOoffXFpAlU',
      contentText:
          'Metaphysics philosophy goes beyond basic concepts such as being, time, space, and causality, questioning the essence of reality. 🔮🌌\n\n'
          'Abstract thoughts add new dimensions to questions that take shape within a logical framework; the mental journey invites you to discover the mysterious layers of the universe. Think critically, question! 🤔📜',
      category: 'advanced',
    ),
    Lesson(
      title: 'Philosophy of Mind',
      imagePath: 'assets/mind_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=3SJROTXnmus',
      contentText:
          'The philosophy of mind deeply examines the limits of mental processes, cognitive abilities, and rational thought. 🧠🔍\n\n'
          'Reasoning interacts with the complex dynamics of human existence, revealing new meanings at the intersection of consciousness and logic. Rediscover the mind maps with the power of critical thinking! 💭✨',
      category: 'advanced',
    ),
    Lesson(
      title: 'Moral Philosophy',
      imagePath: 'assets/morality_lesson.png',
      videoUrl: 'https://www.youtube.com/watch?v=DpDSPVv8lUE',
      contentText:
          'Moral philosophy offers a comprehensive inquiry into ethical norms, values, and responsibilities. 🤝⚖️\n\n'
          'Diversity in ethical paradigms illuminates the origin of human behavior and the evolution of social structure. In-depth analysis allows us to redefine the boundaries of moral judgments. Pursue virtue with critical thinking! 📜🌟',
      category: 'advanced',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedCategory();
  }

  Future<void> _loadSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Eğer kayıtlı kategori yoksa varsayılan olarak "beginner" kullanılır.
      selectedCategory = prefs.getString('selectedCategory') ?? 'beginner';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Seçili kategori yüklenene kadar loading göstergesi veriyoruz.
    if (selectedCategory == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Seçili kategoriye göre dersleri filtreliyoruz.
    final List<Lesson> filteredLessons =
        allLessons
            .where((lesson) => lesson.category == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Hello Philosopher👋')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children:
              filteredLessons
                  .map((lesson) => _lessonCard(context, lesson))
                  .toList(),
        ),
      ),
    );
  }

  Widget _lessonCard(BuildContext context, Lesson lesson) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => LessonDetailScreen(
                  lessonTitle: lesson.title,
                  videoUrl: lesson.videoUrl,
                  lessonContent: lesson.contentText,
                ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(lesson.imagePath, width: 150, height: 150),
            //const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                lesson.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
