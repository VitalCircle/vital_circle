import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../../themes/theme.dart';

const LOREM_IPSUM =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse aliquet fringilla urna vel lacinia. Ut pulvinar dapibus augue, sed tempor lorem efficitur non. Morbi id felis eget augue feugiat dapibus sit amet a neque. Curabitur lectus sapien, semper ut ex quis, bibendum pulvinar diam. Curabitur rutrum dictum lacus, ac semper magna. Suspendisse efficitur venenatis erat, eu ultrices sapien mollis et. Nulla facilisi. Phasellus ullamcorper velit ut viverra vehicula. Mauris vitae augue tellus. Mauris vel semper felis. Duis tincidunt consequat metus at laoreet. Donec velit purus, lobortis vitae felis ut, finibus pharetra ante. Morbi pellentesque tortor odio, et malesuada sapien tincidunt sed. Donec non blandit sapien. Proin ac ex quis risus molestie luctus. Cras eu augue semper, auctor purus eu, mollis tellus. Integer finibus sapien sit amet risus cursus gravida. Fusce tempor id magna sed cursus. Integer facilisis vulputate quam sed auctor. Quisque tincidunt ipsum tellus, non venenatis libero fermentum non. Morbi suscipit condimentum risus, et rhoncus quam. Aliquam eu nunc lectus. Sed faucibus elit vel sollicitudin aliquet. In hac habitasse platea dictumst. Suspendisse eget justo et enim posuere pharetra. Donec et eleifend orci. In tempor metus ut facilisis varius. Integer et nulla luctus, consectetur orci ut, varius sem. Proin facilisis, orci in imperdiet vulputate, justo sem venenatis ante, ut laoreet magna quam a lacus. Duis lacus augue, ultrices sit amet purus sit amet, rhoncus posuere sapien. Nulla ornare eget ante scelerisque faucibus. Pellentesque volutpat lorem sapien. In convallis sollicitudin vulputate. Quisque imperdiet, lectus in suscipit bibendum, enim erat eleifend odio, et molestie libero eros non urna. Nunc bibendum tincidunt magna, vel suscipit nibh dignissim ac. Vivamus arcu magna, suscipit et egestas quis, porta vitae metus. Pellentesque luctus eu sapien eu tristique. Nullam pharetra nibh libero, semper sagittis libero lacinia id. Ut vel eros ut elit tincidunt viverra ut ut nisi. Fusce facilisis ligula sem, eu ornare diam fermentum non. Fusce vitae porta lorem. Fusce sed fringilla erat. Pellentesque semper ut massa egestas viverra. Donec at ornare massa. Morbi eu auctor mauris. Pellentesque lacinia dui vel ligula elementum efficitur. Curabitur id eros magna. Phasellus aliquam lectus vitae orci ullamcorper sollicitudin non at elit. Nullam sit amet urna at quam hendrerit lobortis. Nam vitae convallis turpis, commodo viverra ipsum. Nullam malesuada metus mauris, in hendrerit lectus blandit sed. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque tempus, dui a scelerisque euismod, nulla nibh consequat nulla, id hendrerit velit dolor sed ex. Maecenas auctor metus sit amet sem rutrum ullamcorper. Vivamus sollicitudin leo sollicitudin, semper tellus eget, elementum odio. Cras aliquet sit amet nisi eget porttitor. Etiam venenatis scelerisque orci, congue porta mauris tempor tristique. Donec ultricies vitae lacus eget imperdiet. Nulla vel libero ut sem rutrum facilisis.';

class LegalAgreementScreen extends StatelessWidget {
  const LegalAgreementScreen(
      {@required this.title, @required this.content, @required this.onAccept, @required this.isProcessing});

  final String title;
  final String content;
  final VoidCallback onAccept;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                child: Text(title, style: Theme.of(context).textTheme.display2),
                padding: EdgeInsets.symmetric(vertical: Spacers.lg),
              ),
              Expanded(
                child: SingleChildScrollView(child: Text(content)),
              ),
              SizedBox(height: Spacers.md),
              SizedBox(
                child: ProgressButton(
                  color: AppColors.buttonColorPrimary,
                  label: const Text('Accept'),
                  isProcessing: isProcessing,
                  onPressed: onAccept,
                  type: ProgressButtonType.Raised,
                ),
                width: double.infinity,
              ),
            ],
          ),
        );
      }),
    );
  }
}
