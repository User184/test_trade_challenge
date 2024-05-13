import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:teklub/app/common/components/common_text_widget.dart';
import 'package:teklub/auth/onboarding_screen/widgets/indicator_widget.dart';
import 'package:teklub/scanner/models/mechanic_model.dart';

class MechanicScreen extends StatefulWidget {
  final MechanicModel mechanicModel;

  const MechanicScreen({Key key, this.mechanicModel}) : super(key: key);

  @override
  _MechanicScreenState createState() => _MechanicScreenState();
}

class _MechanicScreenState extends State<MechanicScreen> {
  PageController _pageController;
  int currentIndex = 0;

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  List<Padding> getIndicator(int data) {
    List<Padding> list = [];
    for (var i = 0; i < data; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Indicator(
            mechanic: true,
            positionIndex: i,
            currentIndex: currentIndex,
          ),
        ),
      );
    }
    return list;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3C6FE4),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff3C6FE4),
        centerTitle: true,
        title: const CommonTextWidget(
          text: 'Механики акции',
          size: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: PageView(
                    onPageChanged: onChangedFunction,
                    controller: _pageController,
                    children: widget.mechanicModel.data
                        .map(
                          (e) => SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CommonTextWidget(
                                      overflow: TextOverflow.ellipsis,
                                      text: e.title,
                                      size: 22,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff49536D),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Html(
                                    data: e.body,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, left: 25, right: 25),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: CachedNetworkImage(
                                        imageUrl: e.url,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: Center(
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: getIndicator(widget.mechanicModel.data.length),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
