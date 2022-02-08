import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class SlotEdit extends StatefulWidget {
  final Capacity capacity;

  const SlotEdit({
    Key? key,
    required this.capacity,
  }) : super(key: key);

  @override
  _SlotEditState createState() => _SlotEditState();
}

class _SlotEditState extends State<SlotEdit> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.antiAlias,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: NumberInputPrefabbed.squaredButtons(
                controller: controller,
                initialValue: widget.capacity.slots,
                min: 1,
                max: 99,
                enableMinMaxClamping: true,
                scaleHeight: 1,
                incDecBgColor: Colors.blueGrey.shade50,
                numberFieldDecoration: InputDecoration(
                  fillColor: Colors.blueGrey.shade50,
                  filled: true,
                ),
                onChanged: (newValue) => widget.capacity.slots = newValue.toInt(),
                onSubmitted: (newValue) => widget.capacity.slots = newValue.toInt(),
                onDecrement: (newValue) => widget.capacity.slots = newValue.toInt(),
                onIncrement: (newValue) => widget.capacity.slots = newValue.toInt(),
              ),
            ),
          ],
        ),
        Positioned(
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Kapazität löschen?"),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Abbrechen"),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          CapacityService().removeCapacity(widget.capacity);
                          if (ProviderService().container.read(plannerChangedProvider.state).state) {
                            ProviderService().container.read(plannerUpdateProvider.state).state++;
                          } else {
                            ProviderService().container.read(plannerChangedProvider.state).state = true;
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Löschen"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
      ],
    );
  }
}

/*
TextField(
                controller: controller,
                //enabled: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),

                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
              ),
*/