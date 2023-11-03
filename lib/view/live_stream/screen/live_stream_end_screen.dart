import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:flutter/material.dart';

class LivestreamEndScreen extends StatefulWidget {
  const LivestreamEndScreen({Key? key}) : super(key: key);

  @override
  State<LivestreamEndScreen> createState() => _LivestreamEndScreenState();
}

class _LivestreamEndScreenState extends State<LivestreamEndScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  SessionManager pref = SessionManager();

  String time = '';
  String watching = '';
  String diamond = '';
  String image = '';

  @override
  void initState() {
    prefData();
    super.initState();
  }

  void prefData() async {
    await pref.initPref();
    time = pref.getString(FirebaseConst.timing) ?? '';
    watching = pref.getString(FirebaseConst.watching) ?? '';
    diamond = pref.getString(FirebaseConst.collected) ?? '';
    image = pref.getString(FirebaseConst.profileImage) ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                image.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          '${ConstRes.itemBaseUrl}$image',
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.5,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox();
                          },
                        ))
                    : Image.asset(
                        icUserPlaceHolder,
                        height: MediaQuery.of(context).size.width / 2.5,
                        width: MediaQuery.of(context).size.width / 2.5,
                        fit: BoxFit.cover,
                        color: Colors.grey,
                      ),
                ScaleTransition(
                  scale: _animation,
                  child: Text(
                    S.of(context).yourLiveStreamHasBeenEndednbelowIsASummaryOf,
                    style: TextStyle(fontFamily: fNSfUiBold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizeTransition(
                          sizeFactor: _animation,
                          axis: Axis.horizontal,
                          axisAlignment: -1,
                          child: Text('$time',
                              style: const TextStyle(
                                  fontFamily: fNSfUiSemiBold, fontSize: 15)),
                        ),
                        Text(
                          S.of(context).streamFor,
                          style: TextStyle(
                              fontFamily: fNSfUiSemiBold, fontSize: 15),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizeTransition(
                          sizeFactor: _animation,
                          axis: Axis.horizontal,
                          axisAlignment: -1,
                          child: Text('$watching',
                              style: const TextStyle(
                                  fontFamily: fNSfUiSemiBold, fontSize: 15)),
                        ),
                        Text(
                          S.of(context).users,
                          style: TextStyle(
                              fontFamily: fNSfUiSemiBold, fontSize: 15),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizeTransition(
                          sizeFactor: _animation,
                          axis: Axis.horizontal,
                          axisAlignment: -1,
                          child: Text('$diamond',
                              style: const TextStyle(
                                  fontFamily: fNSfUiSemiBold, fontSize: 15)),
                        ),
                        Text(
                          '💎 ${S.of(context).collected}',
                          style: TextStyle(
                              fontFamily: fNSfUiSemiBold, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: colorTheme.withOpacity(0.13),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).ok,
                          style: TextStyle(
                              color: colorPink,
                              fontFamily: fNSfUiHeavy,
                              letterSpacing: 0.8,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
