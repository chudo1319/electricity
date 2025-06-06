import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ActiveButton extends StatelessWidget {
  const ActiveButton({super.key, required this.text, required this.isSelected});

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? context.color.positive : context.color.onPrimary,
        ),
      ),
    );
  }
}

class TabActiveButtons extends StatelessWidget {
  const TabActiveButtons({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelPadding: EdgeInsets.zero,
      onTap: (index) {
        tabController.animateTo(index);
      },
      tabs: [
        AnimatedBuilder(
          animation: tabController,
          builder: (context, child) {
            return ActiveButton(
              text: 'Текущие',
              isSelected: tabController.index == 0,
            );
          },
        ),
        AnimatedBuilder(
          animation: tabController,
          builder: (context, child) {
            return ActiveButton(
              text: 'Архив',
              isSelected: tabController.index == 1,
            );
          },
        ),
      ],
    );
  }
}
