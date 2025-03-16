import 'package:flutter/material.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class LessonBookletScreen extends StatefulWidget {
  final String lessonTitle;
  final List<String> pdfPages; // PDF sayfa görüntülerinin asset yolları
  final int currentPage;

  const LessonBookletScreen({
    Key? key,
    required this.lessonTitle,
    required this.pdfPages,
    this.currentPage = 0,
  }) : super(key: key);

  @override
  _LessonBookletScreenState createState() => _LessonBookletScreenState();
}

class _LessonBookletScreenState extends State<LessonBookletScreen> {
  @override
  Widget build(BuildContext context) {
    final int currentPage = widget.currentPage;
    final bool hasNext = currentPage < widget.pdfPages.length - 1;
    final bool hasPrevious = currentPage > 0;

    return Scaffold(
      appBar: AppBar(title: Text(widget.lessonTitle)),
      body: Column(
        children: [
          // PDF sayfa görüntüsü (tek sayfa gösterimi)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  widget.pdfPages[currentPage],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Butonlar: Önceki ve Sonraki sayfa
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (hasPrevious)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                LessonBookletScreen(
                                  lessonTitle: widget.lessonTitle,
                                  pdfPages: widget.pdfPages,
                                  currentPage: currentPage - 1,
                                ),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          return TurnPageTransition(
                            animation: animation,
                            overleafColor: Colors.white,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Previous'),
                ),
              if (hasNext)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                LessonBookletScreen(
                                  lessonTitle: widget.lessonTitle,
                                  pdfPages: widget.pdfPages,
                                  currentPage: currentPage + 1,
                                ),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          return TurnPageTransition(
                            animation: animation,
                            overleafColor: Colors.white,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('Next'),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
