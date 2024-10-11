import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import '../components/colors.dart';
import 'StoryViewScreen.dart';


class StoryDetailScreen extends StatefulWidget {
  final List<List<String>> allStories; // All stories as a list of image sets
  final List<String> userNames; // Corresponding usernames
  final int initialIndex; // Index of the first story set to display
  final StoryController _storyController = StoryController();

   StoryDetailScreen({
    Key? key,
    required this.allStories,
    required this.userNames,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _StoryDetailScreenState createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  final StoryController _storyController = StoryController();

  @override
  Widget build(BuildContext context) {
    final List<StoryItem> storyItems = widget.allStories[widget.initialIndex]
        .map(
          (imageUrl) => StoryItem.pageImage(
        url: imageUrl,
        controller: _storyController,
        caption: Text(widget.userNames[widget.initialIndex]),
      ),
    )
        .toList();

    return Scaffold(
      backgroundColor: AppColors.navbarColor,
      body: StoryViewScreen(
        storyItems: [
          StoryItem.text(
            title: "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
            backgroundColor: Colors.orange,
            roundedTop: true,
          ),
          StoryItem.inlineImage(
            url: "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
            controller: widget._storyController,
            caption: Text(
              "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black54,
                fontSize: 17,
              ),
            ),
          ),
          StoryItem.inlineImage(
            url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
            controller: widget._storyController,
            caption: Text(
              "Hektas, sektas and skatad",
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black54,
                fontSize: 17,
              ),
            ),
          ),
        ],
        controller: widget._storyController,
      ),
    );
  }

  @override
  void dispose() {
    _storyController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }
}
