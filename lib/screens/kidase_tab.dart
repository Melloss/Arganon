import 'package:flutter/material.dart';
import '../helper/helper.dart' show ColorPallet, screenWidth;

class KidaseTab extends StatefulWidget {
  const KidaseTab({super.key});

  @override
  State<KidaseTab> createState() => _KidaseTabState();
}

class _KidaseTabState extends State<KidaseTab> with ColorPallet {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
          connectorColor: MaterialStatePropertyAll(foregroundColor),
          steps: [
            Step(
              subtitle: Text(''),
              title:
                  Text('ክፍል ፩', style: Theme.of(context).textTheme.titleLarge),
              content: Column(
                children: [
                  SizedBox(
                    width: screenWidth(context) * 0.8,
                    height: 45,
                    child: MaterialButton(
                      color: foregroundColor,
                      onPressed: () {},
                      child: Text(
                        'eminebeha - tseliyu abewiye',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: screenWidth(context) * 0.8,
                    height: 45,
                    child: MaterialButton(
                      color: foregroundColor,
                      onPressed: () {},
                      child: Text(
                        'tseliyu abwiye - sibhat leab',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
