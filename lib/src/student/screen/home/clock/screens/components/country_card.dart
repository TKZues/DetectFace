import 'package:flutter/material.dart';

import '../../../../../../../utils/config/size_config.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({
    Key? key,
    required this.country,
    required this.iconSrc,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  final String country, iconSrc, image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: SizedBox(
          width: getProportionateScreenWidth(233),
          child: AspectRatio(
            aspectRatio: 1.32,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    // color: Theme.of(context).primaryIconTheme.color,
                    ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                        image,
                        width: psWidth(130),
                        fit: BoxFit.cover,
                      ),
                  Text(
                    country,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: getProportionateScreenWidth(16)),
                  ),
                  const Spacer(),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
