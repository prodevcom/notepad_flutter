import 'package:flutter/material.dart';

class WButton extends StatelessWidget {
  const WButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.loadingLabel,
  });

  final String label;
  final void Function()? onPressed;
  final bool isLoading;
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    var fontSize = Theme.of(context).textTheme.titleMedium?.fontSize ?? 16;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: !isLoading ? onPressed : null,
          child: !isLoading
              ? Text(label, style: TextStyle(fontSize: fontSize))
              : _LoadingButtonMessage(label: loadingLabel)),
    );
  }
}

class _LoadingButtonMessage extends StatelessWidget {
  const _LoadingButtonMessage({this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    var fontSize = Theme.of(context).textTheme.titleMedium?.fontSize ?? 16;
    var circular = const CircularProgressIndicator(strokeWidth: 2);

    var row = <Widget>[SizedBox(height: 20, width: 20, child: circular)];
    if (label != null) {
      row.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text("${label!}...", style: TextStyle(fontSize: fontSize)),
      ));
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: row);
  }
}
