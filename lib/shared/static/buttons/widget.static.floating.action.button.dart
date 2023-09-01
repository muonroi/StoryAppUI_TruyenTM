import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:provider/provider.dart';

@immutable
class ExpandableDraggableFab extends StatefulWidget {
  const ExpandableDraggableFab(
      {super.key,
      this.initialDraggableOffset,
      this.childrenType = ChildrenType.rowChildren,
      this.initialOpen,
      this.onTab,
      this.duration,
      this.closeChildrenRotate = false,
      required this.distance,
      required this.children,
      required this.childrenCount,
      this.childrenTransition,
      this.openWidget,
      this.closeWidget,
      this.childrenAlignment,
      this.curveAnimation,
      this.reverseAnimation,
      this.childrenMargin,
      this.childrenBackgroundColor,
      this.childrenInnerMargin,
      this.enableChildrenAnimation = true,
      this.childrenBoxDecoration,
      this.controller,
      this.fontColor,
      this.backgroundColor,
      required this.isVisibleButtonScroll});
  final KeyChapterButtonScroll isVisibleButtonScroll;
  final ChildrenType? childrenType;
  final ScrollController? controller;
  final Color? fontColor;
  final Color? backgroundColor;

  /// Animation duration.
  final Duration? duration;

  /// Visible children when first navigate.
  final bool? initialOpen;

  /// Close children's rotate animation when open and close
  final bool? closeChildrenRotate;

  /// The callback that is called when the open and close button is tapped or otherwise activated.
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onTab;

  /// Closing widget. Avoid using clickable widgets like floating action button, inkwell etc.
  final Widget? closeWidget;

  /// Opening widget. Avoid using clickable widgets like floating action button, inkwell etc.
  final Widget? openWidget;

  /// Alignment of children.
  final Alignment? childrenAlignment;

  /// Transition of children when open and close.
  final ChildrenTransition? childrenTransition;

  /// Children's curve animation when open.
  final Curve? curveAnimation;

  /// Children's curve animation when close.
  final Curve? reverseAnimation;

  /// Children's animation when open and close.
  final bool? enableChildrenAnimation;

  /// Initial offset of the draggable widget.
  /// Offset(0,0) is the upper right corner. If you want to move it to the bottom right position, subtract the widget height from the device height.
  /// Use hot reload when you set initial position.
  final Offset? initialDraggableOffset;

  /// Children's animation distance when open and close.
  final double distance;

  /// Margin between widgets.
  final EdgeInsets? childrenInnerMargin;

  /// Margin of children.
  final EdgeInsets? childrenMargin;
  final List<Widget> children;
  final int childrenCount;

  /// Children's container color. When you want to more customize use "childrenBoxDecoration".
  final Color? childrenBackgroundColor;

  /// Children's box decoration.
  final BoxDecoration? childrenBoxDecoration;

  @override
  State<ExpandableDraggableFab> createState() => _ExpandableDraggableFabState();
//_ExpandableDraggableFabState createState() => _ExpandableDraggableFabState();
}

class _ExpandableDraggableFabState extends State<ExpandableDraggableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;
  late final Duration _duration;
  final GlobalKey _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _duration = widget.duration ?? const Duration(milliseconds: 500);
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: widget.duration ?? _duration,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: widget.curveAnimation ?? Curves.fastOutSlowIn,
      reverseCurve: widget.reverseAnimation ?? Curves.fastOutSlowIn,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox.expand(
      key: _key,
      child: Stack(
        alignment: widget.childrenAlignment ?? Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          AnimatedSwitcher(
              duration: widget.duration ?? const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                if (widget.childrenTransition ==
                        ChildrenTransition.fadeTransation ||
                    widget.childrenTransition == null) {
                  return FadeTransition(opacity: animation, child: child);
                } else {
                  return ScaleTransition(scale: animation, child: child);
                }
              },
              child: !_open
                  ? const SizedBox.shrink()
                  : Container(
                      decoration: widget.childrenBoxDecoration ??
                          BoxDecoration(
                              color: widget.childrenBackgroundColor ??
                                  Colors.black54,
                              borderRadius: BorderRadius.circular(20)),
                      margin: widget.childrenMargin ??
                          const EdgeInsets.only(
                              top: 100, right: 10, left: 10, bottom: 10),
                      child: widget.childrenType == ChildrenType.rowChildren
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ..._buildExpandingActionButtons(),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [..._buildExpandingActionButtons()],
                              ),
                            ),
                    )),
          Consumer<TemplateSetting>(
            builder: (context, value, child) {
              value.locationButton =
                  value.locationButton ?? widget.isVisibleButtonScroll;
              return DraggableWidget(
                parentKey: _key,
                initialOffset: widget.initialDraggableOffset ??
                    Offset(20, size.height - size.height + 200),
                child: value.locationButton == KeyChapterButtonScroll.none
                    ? Container()
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildTapToOpenFab(),
                        ],
                      ),
              );
            },
          )
        ],
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.childrenCount;
    final step = 18 * count / (count / 2);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          enableOpenAnimation: widget.enableChildrenAnimation!,
          open: _open,
          childrenMargin: widget.childrenInnerMargin,
          closeChildrenRotate: widget.closeChildrenRotate!,
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: _duration,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: widget.children.isEmpty
              ? 1
              : _open
                  ? 0.0
                  : 1.0,
          curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
          duration: _duration,
          child: GestureDetector(
            onTap: () {
              widget.controller?.jumpTo(widget.controller!.offset + 200);
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(93, 160, 158, 158),
                        width: 6.0),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(1, 2),
                          blurRadius: 4,
                          spreadRadius: 2,
                          color: Colors.transparent)
                    ],
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(43, 111, 111, 110)),
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 60)
                        .width,
                height:
                    MainSetting.getPercentageOfDevice(context, expectHeight: 60)
                        .height,
                child: const Icon(
                  size: 35,
                  Icons.keyboard_double_arrow_down,
                  color: Color.fromARGB(93, 132, 131, 131),
                )),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton(
      {required this.childrenMargin,
      required this.directionInDegrees,
      required this.maxDistance,
      required this.progress,
      required this.child,
      required this.open,
      required this.closeChildrenRotate,
      required this.enableOpenAnimation});

  final bool closeChildrenRotate;
  final bool open;
  final bool enableOpenAnimation;
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;
  final EdgeInsets? childrenMargin;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset(
          directionInDegrees * (math.pi / 180),
          maxDistance * (1 - progress.value),
        );
        return Padding(
            padding: childrenMargin ?? const EdgeInsets.all(10),
            child: Transform.rotate(
                angle: closeChildrenRotate == true
                    ? 0
                    : (1.0 - progress.value) * math.pi,
                child: Padding(
                    padding: enableOpenAnimation
                        ? EdgeInsets.symmetric(
                            vertical: open ? offset.dy : 0,
                            horizontal: open ? offset.dy : 0)
                        : EdgeInsets.zero,
                    child: child!)));
      },
      child: FadeTransition(opacity: progress, child: child),
    );
  }
}

class NoScalingAnimation extends FloatingActionButtonAnimator {
  @override
  Offset getOffset(
      {required Offset begin, required Offset end, required double progress}) {
    return end;
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}

class ExpandableFloatLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return const Offset(0, 0);
  }
}

enum ChildrenTransition { scaleTransation, fadeTransation }

enum ChildrenType {
  rowChildren,
  columnChildren,
}

class DraggableWidget extends StatefulWidget {
  final GlobalKey parentKey;
  final Widget child;
  final Offset initialOffset;

  const DraggableWidget({
    Key? key,
    required this.child,
    required this.initialOffset,
    required this.parentKey,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  final GlobalKey _key = GlobalKey();

  bool _isDragging = false;
  late Offset _offset;
  late Offset _minOffset;
  late Offset _maxOffset;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setBoundary();
    });
    //  Future.delayed(const Duration(seconds: 1),_setBoundary);
  }

  void _setBoundary() {
    final RenderBox parentRenderBox =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

    try {
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;

      setState(() {
        _minOffset = const Offset(0, 0);
        _maxOffset = Offset(
            parentSize.width - size.width, parentSize.height - size.height);
      });
    } catch (e) {
      debugPrint('catch: $e');
    }
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent) {
    double newOffsetX = _offset.dx + (-pointerMoveEvent.delta.dx);
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    if (newOffsetX < _minOffset.dx) {
      newOffsetX = _minOffset.dx;
    } else if (newOffsetX > _maxOffset.dx) {
      newOffsetX = _maxOffset.dx;
    }

    if (newOffsetY < _minOffset.dy) {
      newOffsetY = _minOffset.dy;
    } else if (newOffsetY > _maxOffset.dy) {
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent) {
          _updatePosition(pointerMoveEvent);

          setState(() {
            _isDragging = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent) {
          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {}
        },
        child: Container(
          key: _key,
          child: widget.child,
        ),
      ),
    );
  }
}
