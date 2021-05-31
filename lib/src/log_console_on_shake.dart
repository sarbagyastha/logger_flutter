part of logger_flutter;

class LogConsoleOnShake extends StatefulWidget {
  final Widget child;
  final bool dark;
  final bool show;

  LogConsoleOnShake({
    required this.child,
    this.dark = true,
    this.show = true,
  });

  @override
  _LogConsoleOnShakeState createState() => _LogConsoleOnShakeState();
}

class _LogConsoleOnShakeState extends State<LogConsoleOnShake> {
  late ShakeDetector _detector;
  bool _open = false;

  @override
  void initState() {
    super.initState();

    if (widget.show) _init();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  bool _init() {
    _detector = ShakeDetector(
      onPhoneShake: _openLogConsole,
      minShakeCount: 10,
    );
    _detector.startListening();
    return true;
  }

  void _openLogConsole() async {
    if (_open) return;

    _open = true;
    await LogConsole.open(context, dark: widget.dark);
    _open = false;
  }

  @override
  void dispose() {
    _detector.stopListening();
    super.dispose();
  }
}
