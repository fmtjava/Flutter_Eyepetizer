import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool loading;
  final bool cover;

  const LoadingContainer(
      {Key key,
      @required this.loading,
      this.cover = false,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !loading ? child : _loadView
        : Stack(
            children: <Widget>[child, loading ? _loadView : null],
          );
  }

  Widget get _loadView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
