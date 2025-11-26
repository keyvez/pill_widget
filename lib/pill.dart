import 'package:flutter/material.dart';

/// Style configuration for the [Pill] widget.
///
/// Use [PillStyle] to customize the appearance of a pill, including colors,
/// border radius, and text styles. All properties are optional and will
/// fall back to sensible defaults if not specified.
///
/// Example:
/// ```dart
/// Pill(
///   label: 'Status',
///   value: 'Active',
///   style: PillStyle(
///     backgroundColor: Colors.green.shade50,
///     borderColor: Colors.green.shade200,
///     labelColor: Colors.green.shade800,
///   ),
/// )
/// ```
class PillStyle {
  /// Creates a [PillStyle] with the given properties.
  const PillStyle({
    this.backgroundColor,
    this.borderColor,
    this.labelColor,
    this.valueColor,
    this.dividerColor,
    this.borderWidth,
    this.borderRadius,
    this.labelFontWeight,
    this.valueFontWeight,
    this.fontSize,
  });

  /// The background color of the pill.
  ///
  /// Defaults to transparent.
  final Color? backgroundColor;

  /// The border color of the pill.
  ///
  /// Defaults to [Colors.black].
  final Color? borderColor;

  /// The color of the label text.
  ///
  /// Defaults to [Colors.black].
  final Color? labelColor;

  /// The color of the value text.
  ///
  /// Defaults to the label color if not specified.
  final Color? valueColor;

  /// The color of the divider between label and value.
  ///
  /// Defaults to the border color if not specified.
  final Color? dividerColor;

  /// The width of the border.
  ///
  /// Defaults to 1.0.
  final double? borderWidth;

  /// The border radius of the pill.
  ///
  /// Defaults to 24.0.
  final double? borderRadius;

  /// The font weight of the label text.
  ///
  /// Defaults to [FontWeight.bold].
  final FontWeight? labelFontWeight;

  /// The font weight of the value text.
  ///
  /// Defaults to [FontWeight.normal].
  final FontWeight? valueFontWeight;

  /// The font size for both label and value text.
  ///
  /// Defaults to the theme's body medium text size.
  final double? fontSize;

  /// Creates a copy of this [PillStyle] with the given fields replaced.
  PillStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? labelColor,
    Color? valueColor,
    Color? dividerColor,
    double? borderWidth,
    double? borderRadius,
    FontWeight? labelFontWeight,
    FontWeight? valueFontWeight,
    double? fontSize,
  }) {
    return PillStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      labelColor: labelColor ?? this.labelColor,
      valueColor: valueColor ?? this.valueColor,
      dividerColor: dividerColor ?? this.dividerColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      labelFontWeight: labelFontWeight ?? this.labelFontWeight,
      valueFontWeight: valueFontWeight ?? this.valueFontWeight,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  /// Merges this style with another, with the other style taking precedence.
  PillStyle merge(PillStyle? other) {
    if (other == null) return this;
    return PillStyle(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      borderColor: other.borderColor ?? borderColor,
      labelColor: other.labelColor ?? labelColor,
      valueColor: other.valueColor ?? valueColor,
      dividerColor: other.dividerColor ?? dividerColor,
      borderWidth: other.borderWidth ?? borderWidth,
      borderRadius: other.borderRadius ?? borderRadius,
      labelFontWeight: other.labelFontWeight ?? labelFontWeight,
      valueFontWeight: other.valueFontWeight ?? valueFontWeight,
      fontSize: other.fontSize ?? fontSize,
    );
  }
}

/// A collection of predefined [PillStyle] presets for common use cases.
///
/// These presets provide ready-to-use color schemes for different contexts
/// such as success states, warnings, errors, and informational pills.
class PillStyles {
  PillStyles._();

  /// Default style with black border on transparent background.
  static const PillStyle defaultStyle = PillStyle();

  /// Blue-themed style for informational content.
  static const PillStyle info = PillStyle(
    backgroundColor: Color(0xFFE3F2FD),
    borderColor: Color(0xFF90CAF9),
    labelColor: Color(0xFF1565C0),
  );

  /// Green-themed style for success states or positive content.
  static const PillStyle success = PillStyle(
    backgroundColor: Color(0xFFE8F5E9),
    borderColor: Color(0xFFA5D6A7),
    labelColor: Color(0xFF2E7D32),
  );

  /// Orange-themed style for warning states.
  static const PillStyle warning = PillStyle(
    backgroundColor: Color(0xFFFFF3E0),
    borderColor: Color(0xFFFFCC80),
    labelColor: Color(0xFFEF6C00),
  );

  /// Red-themed style for error states or critical content.
  static const PillStyle error = PillStyle(
    backgroundColor: Color(0xFFFFEBEE),
    borderColor: Color(0xFFEF9A9A),
    labelColor: Color(0xFFC62828),
  );

  /// Purple-themed style for special or highlighted content.
  static const PillStyle special = PillStyle(
    backgroundColor: Color(0xFFF3E5F5),
    borderColor: Color(0xFFCE93D8),
    labelColor: Color(0xFF7B1FA2),
  );

  /// Cyan-themed style for neutral or secondary content.
  static const PillStyle neutral = PillStyle(
    backgroundColor: Color(0xFFE0F7FA),
    borderColor: Color(0xFF80DEEA),
    labelColor: Color(0xFF00838F),
  );

  /// Grey-themed style for disabled or muted content.
  static const PillStyle muted = PillStyle(
    backgroundColor: Color(0xFFF5F5F5),
    borderColor: Color(0xFFE0E0E0),
    labelColor: Color(0xFF616161),
  );

  /// Pink-themed style for date/time or temporal content.
  static const PillStyle date = PillStyle(
    backgroundColor: Color(0xFFFCE4EC),
    borderColor: Color(0xFFF48FB1),
    labelColor: Color(0xFFC2185B),
  );
}

/// A pill-shaped widget that displays a label and an optional editable value.
///
/// The [Pill] widget is designed to show a tag or property in a compact form.
/// It consists of a [label] on the left and an optional [value] on the right.
///
/// If [value] is provided, the pill displays a separator line between the label
/// and the value. When the user taps on the pill, it switches to an editing mode
/// (if [value] is not null and [editable] is true), allowing the user to modify
/// the text.
///
/// When editing is finished (by submitting or losing focus), the [onValueChanged]
/// callback is triggered with the new value.
///
/// ## Basic Usage
///
/// Label-only pill:
/// ```dart
/// Pill(label: 'Status')
/// ```
///
/// Label with value:
/// ```dart
/// Pill(label: 'Name', value: 'John Doe')
/// ```
///
/// ## Styling
///
/// Use the [style] parameter to customize the appearance:
/// ```dart
/// Pill(
///   label: 'Email',
///   value: 'john@example.com',
///   style: PillStyles.info,
/// )
/// ```
///
/// Or create a custom style:
/// ```dart
/// Pill(
///   label: 'Custom',
///   style: PillStyle(
///     backgroundColor: Colors.amber.shade50,
///     borderColor: Colors.amber,
///     labelColor: Colors.amber.shade900,
///   ),
/// )
/// ```
///
/// ## Editing
///
/// Enable editing by providing an [onValueChanged] callback:
/// ```dart
/// Pill(
///   label: 'Name',
///   value: _name,
///   onValueChanged: (newValue) => setState(() => _name = newValue),
/// )
/// ```
///
/// Disable editing while still showing a value:
/// ```dart
/// Pill(
///   label: 'Name',
///   value: 'John Doe',
///   editable: false,
/// )
/// ```
class Pill extends StatefulWidget {
  /// Creates a [Pill] widget.
  ///
  /// The [label] parameter is required.
  /// If [value] is null, the pill will display only the label.
  const Pill({
    super.key,
    required this.label,
    this.value,
    this.onValueChanged,
    this.style,
    this.editable = true,
    this.expandable = false,
    this.onTap,
  });

  /// The text displayed on the left side of the pill.
  final String label;

  /// The text displayed on the right side of the pill.
  ///
  /// If null, the pill displays only the [label].
  /// If non-null and [editable] is true, tapping the pill enables inline editing.
  final String? value;

  /// Called when the user finishes editing the value.
  ///
  /// This callback is invoked with the new text string when the user submits
  /// the change (e.g., presses Enter) or when the text field loses focus.
  final ValueChanged<String>? onValueChanged;

  /// The style configuration for this pill.
  ///
  /// If null, the pill uses the default black border on transparent background.
  /// Use [PillStyles] for predefined color schemes, or create a custom [PillStyle].
  final PillStyle? style;

  /// Whether the value can be edited by tapping.
  ///
  /// Defaults to true. Set to false to display a read-only pill with a value.
  final bool editable;

  /// Whether the pill expands to show the full value when tapped.
  ///
  /// If true, tapping the pill toggles between single-line (truncated) and
  /// multi-line (full) display of the [value].
  /// This takes precedence over [editable] - if both are true, tap will expand.
  ///
  /// Defaults to false.
  final bool expandable;

  /// Called when the pill is tapped.
  ///
  /// This is called regardless of whether the pill is editable. If [editable]
  /// is true and [value] is not null, editing mode will also be triggered.
  final VoidCallback? onTap;

  @override
  State<Pill> createState() => _PillState();
}

class _PillState extends State<Pill> with SingleTickerProviderStateMixin {
  bool _isEditing = false;
  bool _isExpanded = false;
  late TextEditingController _textController;
  late FocusNode _focusNode;

  static const _valueHeight = 24.0;
  static const _valueStrutStyle = StrutStyle(
    height: 1.0,
    forceStrutHeight: true,
  );

  // Resolved style values
  Color get _backgroundColor =>
      widget.style?.backgroundColor ?? Colors.transparent;
  Color get _borderColor => widget.style?.borderColor ?? Colors.black;
  Color get _labelColor => widget.style?.labelColor ?? Colors.black;
  Color get _valueColor => widget.style?.valueColor ?? _labelColor;
  Color get _dividerColor => widget.style?.dividerColor ?? _borderColor;
  double get _borderWidth => widget.style?.borderWidth ?? 1.0;
  double get _borderRadius => widget.style?.borderRadius ?? 24.0;
  FontWeight get _labelFontWeight =>
      widget.style?.labelFontWeight ?? FontWeight.bold;
  FontWeight get _valueFontWeight =>
      widget.style?.valueFontWeight ?? FontWeight.normal;

  BoxDecoration get _decoration => BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        border: Border.all(color: _borderColor, width: _borderWidth),
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
        widget.onTap?.call();
        if (widget.expandable) {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        } else if (widget.value != null && widget.editable) {
          setState(() {
            _isEditing = true;
          });
          _focusNode.requestFocus();
        }
      },
      child: DecoratedBox(
        decoration: _decoration,
        child: _isEditing ? _buildEditingView() : _buildDisplayView(),
      ),
    );
  }

  Widget _buildDisplayView() {
    final labelStyle = TextStyle(
      fontWeight: _labelFontWeight,
      color: _labelColor,
      fontSize: widget.style?.fontSize,
    );

    if (widget.value == null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 7.0,
          bottom: 9.0,
        ),
        child: Text(widget.label, style: labelStyle),
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
            child: Text(widget.label, style: labelStyle),
          ),
          _PillDivider(color: _dividerColor),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.5,
                right: 16.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child: _isExpanded
                  ? Text(
                      widget.value!,
                      style: valueTextStyle,
                      strutStyle: _valueStrutStyle,
                    )
                  : Text(
                      widget.value!,
                      style: valueTextStyle,
                      strutStyle: _valueStrutStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildEditingView() {
    final labelStyle = TextStyle(
      fontWeight: _labelFontWeight,
      color: _labelColor,
      fontSize: widget.style?.fontSize,
    );
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
          child: Text(widget.label, style: labelStyle),
        ),
        _PillDivider(color: _dividerColor),
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final textSpan = TextSpan(
                    text: _textController.text,
                    style: valueTextStyle,
                  );
                  final textPainter = TextPainter(
                    text: textSpan,
                    textDirection: Directionality.of(context),
                    maxLines: 1,
                  )..layout(minWidth: 0, maxWidth: constraints.maxWidth);

                  // Add a small buffer for the cursor and to prevent jitter
                  final textWidth = textPainter.width + 10.0;

                  return SizedBox(
                    width: textWidth,
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
                      cursorColor: _valueColor,
                      onSubmitted: (newValue) {
                        _commitEditingValue();
                        setState(() {
                          _isEditing = false;
                        });
                        _focusNode.unfocus();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _valueTextStyle(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium;
    return (base ?? const TextStyle()).copyWith(
      height: 1.0,
      color: _valueColor,
      fontWeight: _valueFontWeight,
      fontSize: widget.style?.fontSize,
    );
  }

  void _commitEditingValue() {
    final newValue = _textController.text;
    widget.onValueChanged?.call(newValue);
  }
}

class _PillDivider extends StatelessWidget {
  const _PillDivider({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0,
      height: 24.0,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: color ?? Colors.black,
    );
  }
}
