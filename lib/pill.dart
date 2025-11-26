import 'package:flutter/material.dart';

/// A pill-shaped widget that displays a label and an optional editable value.
///
/// The [Pill] widget is designed to show a tag or property in a compact form.
/// It consists of a [label] on the left and an optional [value] on the right.
///
/// If [value] is provided, the pill displays a separator line between the label
/// and the value. When the user taps on the pill, it switches to an editing mode
/// (if [value] is not null), allowing the user to modify the text.
///
/// When editing is finished (by submitting or losing focus), the [onValueChanged]
/// callback is triggered with the new value.
class Pill extends StatefulWidget {
  /// Creates a [Pill] widget.
  ///
  /// The [label] parameter is required.
  /// If [value] is null, the pill will display only the label.
  const Pill({super.key, required this.label, this.value, this.onValueChanged});

  /// The text displayed on the left side of the pill.
  final String label;

  /// The text displayed on the right side of the pill.
  ///
  /// If null, the pill displays only the [label].
  /// If non-null, tapping the pill enables inline editing.
  final String? value;

  /// Called when the user finishes editing the value.
  ///
  /// This callback is invoked with the new text string when the user submits
  /// the change (e.g., presses Enter) or when the text field loses focus.
  final ValueChanged<String>? onValueChanged;

  @override
  State<Pill> createState() => _PillState();
}

class _PillState extends State<Pill> with SingleTickerProviderStateMixin {
  bool _isEditing = false;
  late TextEditingController _textController;
  late FocusNode _focusNode;
  static const _inactiveDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(24.0)),
    border: Border.fromBorderSide(BorderSide(color: Colors.black, width: 1.0)),
  );
  static const _editingDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(24.0)),
    border: Border.fromBorderSide(BorderSide(color: Colors.black, width: 1.0)),
  );
  static const _valueHeight = 24.0;
  static const _valueStrutStyle = StrutStyle(
    height: 1.0,
    forceStrutHeight: true,
  );

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.value ?? '');
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _commitEditingValue();
        setState(() {
          _isEditing = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant Pill oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditing && widget.value != oldWidget.value) {
      _textController.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.value != null) {
          setState(() {
            _isEditing = true;
          });
          _focusNode.requestFocus();
        }
      },
      child: DecoratedBox(
        decoration: _isEditing ? _editingDecoration : _inactiveDecoration,
        child: _isEditing ? _buildEditingView() : _buildDisplayView(),
      ),
    );
  }

  Widget _buildDisplayView() {
    if (widget.value == null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 7.0,
          bottom: 9.0,
        ),
        child: Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    } else {
      final valueTextStyle = _valueTextStyle(context);
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 8.5,
              top: 6.0,
              bottom: 8.0,
            ),
            child: Text(
              widget.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const _PillDivider(),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.5,
              right: 16.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: SizedBox(
              height: _valueHeight,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.value!,
                  style: valueTextStyle,
                  strutStyle: _valueStrutStyle,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildEditingView() {
    final valueTextStyle = _valueTextStyle(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 8.5,
            top: 6.0,
            bottom: 8.0,
          ),
          child: Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const _PillDivider(),
        Padding(
          padding: const EdgeInsets.only(
            left: 8.5,
            right: 16.0,
            top: 8.0,
            bottom: 8.0,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _valueHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IntrinsicWidth(
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  autofocus: true,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    constraints: BoxConstraints.tightFor(height: _valueHeight),
                  ),
                  style: valueTextStyle,
                  strutStyle: _valueStrutStyle,
                  cursorHeight: valueTextStyle.fontSize,
                  onSubmitted: (newValue) {
                    _commitEditingValue();
                    setState(() {
                      _isEditing = false;
                    });
                    _focusNode.unfocus();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _valueTextStyle(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium;
    return (base ?? const TextStyle()).copyWith(height: 1.0);
  }

  void _commitEditingValue() {
    final newValue = _textController.text;
    widget.onValueChanged?.call(newValue);
  }
}

class _PillDivider extends StatelessWidget {
  const _PillDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0,
      height: 24.0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: Colors.black,
    );
  }
}
