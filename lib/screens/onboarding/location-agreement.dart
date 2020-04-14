import 'package:flutter/material.dart';

class LocationAgreementScreen extends StatelessWidget {
  const LocationAgreementScreen({@required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('Location Sharing'),
                  RaisedButton(
                    onPressed: _onAccept,
                    child:  const Text('Accept'),
                  ),
                  FlatButton(
                    onPressed: _onSkip,
                    child: const Text('Skip'),
                  )
                ],
              ),
            ));
      }),
    );
  }

  void _onAccept() {
    // TODO: Persist
    onNext();
  }

  void _onSkip() {
    onNext();
  }
}
