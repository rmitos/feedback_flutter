import '../better_feedback.dart';
import '../l18n/translation.dart';
import '../theme/feedback_theme.dart';
import 'package:flutter/material.dart';

/// Prompt the user for feedback using `StringFeedback`.
Widget simpleFeedbackBuilder(
  BuildContext context,
  OnSubmit onSubmit,
  ScrollController? scrollController,
) =>
    StringFeedback(onSubmit: onSubmit, scrollController: scrollController);

/// A form that prompts the user for feedback with a single text field.
/// This is the default feedback widget used by [BetterFeedback].
class StringFeedback extends StatefulWidget {
  /// Create a [StringFeedback].
  /// This is the default feedback bottom sheet, which is presented to the user.
  const StringFeedback({
    super.key,
    required this.onSubmit,
    required this.scrollController,
  });

  /// Should be called when the user taps the submit button.
  final OnSubmit onSubmit;

  /// A scroll controller that expands the sheet when it's attached to a
  /// scrollable widget and that widget is scrolled.
  ///
  /// Non null if the sheet is draggable.
  /// See: [FeedbackThemeData.sheetIsDraggable].
  final ScrollController? scrollController;

  @override
  State<StringFeedback> createState() => _StringFeedbackState();
}

class _StringFeedbackState extends State<StringFeedback> {
  late TextEditingController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ListView(
                controller: widget.scrollController,
                // Pad the top by 20 to match the corner radius if drag enabled.
                padding: EdgeInsets.fromLTRB(16, widget.scrollController != null ? 20 : 16, 16, 0),
                children: <Widget>[
                  Text(
                    FeedbackLocalizations.of(context).feedbackDescriptionText,
                    maxLines: 2,
                    style: FeedbackTheme.of(context).bottomSheetDescriptionStyle,
                  ),
                  TextField(
                    style: FeedbackTheme.of(context).bottomSheetTextInputStyle,
                    key: const Key('text_input_field'),
                    maxLines: 2,
                    minLines: 2,
                    controller: controller,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.zero,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue.withOpacity(0.3)),
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onChanged: (_) {
                      //print(_);
                    },
                  ),
                ],
              ),
              if (widget.scrollController != null) const FeedbackSheetDragHandle(),
            ],
          ),
        ),
        OutlinedButton(
          key: const Key('submit_feedback_button'),
          onPressed: () => widget.onSubmit(controller.text),
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xffe74c3c),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            side: const BorderSide(color: Color(0xffe74c3c)),
          ),
          child: Text(
            FeedbackLocalizations.of(context).submitButtonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
