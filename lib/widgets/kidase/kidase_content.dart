import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../helper/helper.dart' show ColorPallet;

class KidaseContent extends StatefulWidget {
  final String content;
  final String meaning;
  final String whoShouldSay;
  final String fileId;
  final bool isAmharic;
  const KidaseContent(
      {super.key,
      required this.content,
      required this.meaning,
      required this.whoShouldSay,
      required this.fileId,
      this.isAmharic = false});

  @override
  State<KidaseContent> createState() => _KidaseContentState();
}

class _KidaseContentState extends State<KidaseContent> with ColorPallet {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 10, bottom: 33, top: 5, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                      text: widget.whoShouldSay == ''
                          ? ''
                          : '${widget.whoShouldSay}፦ ',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 15,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                      children: [
                        TextSpan(
                          text: widget.content,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: widget.meaning == '' &&
                                        widget.isAmharic == false
                                    ? 11.5
                                    : 17,
                                color: Colors.white,
                              ),
                        ),
                      ]),
                ],
              )),
              Expanded(child: Container()),
              Visibility(
                visible: widget.meaning != '' && widget.isAmharic == false,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_circle,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.meaning.isNotEmpty,
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              collapsedTextColor: Colors.lime,
              textColor: Colors.limeAccent,
              title: const Text('ትርጉም'),
              iconColor: Colors.limeAccent,
              collapsedIconColor: Colors.lime,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.meaning,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 17,
                          color: Colors.limeAccent,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
