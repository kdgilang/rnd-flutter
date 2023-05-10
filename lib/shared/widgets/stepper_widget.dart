import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({
    super.key,
    this.initialValue,
    this.maxValue,
    required this.onChanged,
    this.direction = Axis.horizontal,
    this.withSpring = true,
  });
  

  /// the orientation of the stepper its horizontal or vertical.
  final Axis direction;

  /// the initial value of the stepper
  final int? initialValue;

  final int? maxValue;

  /// called whenever the value of the stepper changed
  final ValueChanged<int> onChanged;

  /// if you want a springSimulation to happens the the user let go the stepper
  /// defaults to true
  final bool withSpring;

  // Coded By Raj Chowdhury
  
  @override
  Stepper2State createState() => Stepper2State();
}


class Stepper2State extends State<StepperWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late int _value;
  late double _startAnimationPosX;
  late double _startAnimationPosY;

  
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? 0;
    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller.value = 0.0;
    _controller.addListener(() {});

    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: const Offset(0.0, 0.0), end: const Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: const Offset(0.0, 0.0), end: const Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction == Axis.horizontal) {
      _animation = Tween<Offset>(begin: const Offset(0.0, 0.0), end: const Offset(1.5, 0.0))
          .animate(_controller);
    } else {
      _animation = Tween<Offset>(begin: const Offset(0.0, 0.0), end: const Offset(0.0, 1.5))
          .animate(_controller);
    }
  }

  // !test = init();
  
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: widget.direction == Axis.horizontal ? 350.0 : 130.0,
        height: widget.direction == Axis.horizontal ? 130.0 : 350.0,
        child: Material(
          type: MaterialType.canvas,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(60.0),
          color: Colors.white.withOpacity(0.2),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: widget.direction == Axis.horizontal ? 20.0 : null,
                bottom: widget.direction == Axis.horizontal ? null : 20.0,
                child: IconButton(
                  iconSize: 50,
                  onPressed: () {
                    _onCalculate('min');
                  },
                  icon: const Icon(Icons.remove)
                ),
              ),
              Positioned(
                right: widget.direction == Axis.horizontal ? 20.0 : null,
                top: widget.direction == Axis.horizontal ? null : 20.0,
                child: IconButton(
                  iconSize: 50,
                  onPressed: () {
                    _onCalculate('plus');
                  },
                  icon: const Icon(Icons.add)
                ),
              ),
              GestureDetector(
                onHorizontalDragStart: _onPanStart,
                onHorizontalDragUpdate: _onPanUpdate,
                onHorizontalDragEnd: _onPanEnd,
                child: SlideTransition(
                  position: _animation,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 5.0,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child
                          );
                        },
                        child: Text(
                          '$_value',
                          key: ValueKey<int>(_value),
                          style: const TextStyle(
                              color: Color(0xFF6D72FF), fontSize: 56.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  double offsetFromGlobalPos(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset local = box.globalToLocal(globalPosition);
    _startAnimationPosX = ((local.dx * 0.75) / box.size.width) - 0.4;
    _startAnimationPosY = ((local.dy * 0.75) / box.size.height) - 0.4;
    if (widget.direction == Axis.horizontal) {
      return ((local.dx * 0.75) / box.size.width) - 0.4;
    } else {
      return ((local.dy * 0.75) / box.size.height) - 0.4;
    }
  }

  
  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _controller.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onCalculate(String type) {

    if (type == 'plus') {
      int maxValue = widget.maxValue ?? 500;

      if (_value >= maxValue) return;

      setState(() => _value++);
    } else {

      if (_value < 1) return;

      setState(() => _value--);
    }
    
    widget.onChanged(_value);
  }
  
  void _onPanEnd(DragEndDetails details) {
    _controller.stop();
    bool isHor = widget.direction == Axis.horizontal;

    if (isHor) {
      if (_controller.value <= -0.20) {
        _onCalculate('min');
      } else if (_controller.value >= 0.20) {
        _onCalculate('plus');
      } 
    }

    if (widget.withSpring) {
      final SpringDescription kDefaultSpring = SpringDescription.withDampingRatio(
        mass: 0.9,
        stiffness: 250.0,
        ratio: 0.6,
      );
      if (widget.direction == Axis.horizontal) {
        _controller.animateWith(
            SpringSimulation(kDefaultSpring, _startAnimationPosX, 0.0, 0.0));
      } else {
        _controller.animateWith(
            SpringSimulation(kDefaultSpring, _startAnimationPosY, 0.0, 0.0));
      }
    } else {
      _controller.animateTo(0.0,
          curve: Curves.bounceOut, duration: const Duration(milliseconds: 500));
    }
  }
}
