import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';

class Storyview extends StatefulWidget {
  const Storyview({super.key});

  @override
  State<Storyview> createState() => _StoryviewState();
}

class _StoryviewState extends State<Storyview> {
  @override
  final controller = StoryController();

  @override
  Widget build(context) {
    List<StoryItem> storyItems = [
      StoryItem.text(title: 'welcome to my app',backgroundColor: Colors.cyan),
      StoryItem.pageImage(url: 'https://unsplash.com/photos/e616t35Vbeg', controller: controller),
      StoryItem.pageImage(url: 'https://images.unsplash.com/photo-1566438480900-0609be27a4be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=394&q=80', controller: controller,),
      StoryItem.pageImage(url: 'https://images.unsplash.com/photo-1566438480900-0609be27a4be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=394&q=80', controller: controller,),
      StoryItem.pageImage(url: 'https://images.unsplash.com/photo-1566438480900-0609be27a4be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=394&q=80', controller: controller,),

    ]; // your list of stories

    return StoryView(
        storyItems: storyItems,
        controller: controller, // pass controller here too
        repeat: true, // should the stories be slid forever
        onComplete: () {
          Navigator.pop(context);
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        } // To disable vertical swipe gestures, ignore this parameter.
      // Preferrably for inline story view.
    );
  }
  }

