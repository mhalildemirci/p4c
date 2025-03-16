import 'package:flutter/material.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class ActivityBookletScreen extends StatefulWidget {
  final String activityTitle;
  final List<String>
  pdfPages; // Aktivite kitapçığındaki sayfa görsellerinin asset yolları
  final int currentPage;

  const ActivityBookletScreen({
    Key? key,
    required this.activityTitle,
    required this.pdfPages,
    this.currentPage = 0,
  }) : super(key: key);

  @override
  _ActivityBookletScreenState createState() => _ActivityBookletScreenState();
}

class _ActivityBookletScreenState extends State<ActivityBookletScreen> {
  @override
  Widget build(BuildContext context) {
    final int currentPage = widget.currentPage;
    final bool hasNext = currentPage < widget.pdfPages.length - 1;
    final bool hasPrevious = currentPage > 0;

    return Scaffold(
      appBar: AppBar(title: Text(widget.activityTitle)),
      body: Column(
        children: [
          // Aktivite kitapçığındaki sayfa görüntüsü
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
          // Sayfa geçiş butonları
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (hasPrevious)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      TurnPageRoute(
                        builder:
                            (context) => ActivityBookletScreen(
                              activityTitle: widget.activityTitle,
                              pdfPages: widget.pdfPages,
                              currentPage: currentPage - 1,
                            ),
                        transitionDuration: const Duration(milliseconds: 500),
                        overleafColor: Colors.white,
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
                      TurnPageRoute(
                        builder:
                            (context) => ActivityBookletScreen(
                              activityTitle: widget.activityTitle,
                              pdfPages: widget.pdfPages,
                              currentPage: currentPage + 1,
                            ),
                        transitionDuration: const Duration(milliseconds: 500),
                        overleafColor: Colors.white,
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
