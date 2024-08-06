import 'package:flutter/material.dart';
import 'package:mobile_test/core/utils/color_manager.dart';
import 'package:mobile_test/core/utils/font_manager.dart';
import 'package:mobile_test/features/home/domain/entities/food.dart';

class FoodWidget extends StatelessWidget {
  final Food food;
  const FoodWidget({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            food.image,
            width: 85,
            height: 85,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            food.name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.primary,
                  fontWeight: FontWeightManager.bold,
                ),
          ),
        ],
      ),
    );
  }
}
