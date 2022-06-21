import 'package:flutter/material.dart';

class ExpandablePageView extends StatefulWidget {
  final PageController pageController;
  final List<double> pageHeights;
  final Widget? child;

  const ExpandablePageView({
    Key? key,
    required this.pageController,
    required this.pageHeights,
    required this.child,
  }) : super(key: key);

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView> {
  int _currentPage = 0;
  int _previousPage = 0;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_updatePage);
    super.dispose();
  }

  void _setup() {
    _currentPage = widget.pageController.initialPage;
    _previousPage = _getPreviousPage();
    widget.pageController.addListener(_updatePage);
  }

  double get _currentHeight => widget.pageHeights[_currentPage];
  double get _previousHeight => widget.pageHeights[_previousPage];

  int _getPreviousPage() {
    if (_currentPage - 1 < 0) {
      return 0;
    }

    return _currentPage - 1;
  }

  void _updatePage() {
    final newPage = widget.pageController.page!.round();

    if (_currentPage != newPage) {
      setState(() {
        _previousPage = _currentPage;
        _currentPage = newPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 0),
      tween: Tween<double>(begin: _previousHeight, end: _currentHeight),
      builder: (BuildContext context, double value, Widget? child) =>
          SizedBox(height: value, child: child),
      child: widget.child,
    );
  }
}
