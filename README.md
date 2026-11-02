# Introduction

A Flutter package for controlling child paint order in a Flex layout.

It extends Flutter's standard Flex behavior, preserving layout positions, spacing, and flex sizing while allowing overlapping children to be drawn in a different order.

```dart
import 'package:paint_order_flex/paint_order_flex.dart';

PaintOrderFlex(
  direction: .vertical,
  children: [
    PaintOrder(order: 2, child: ...), // last painted
    PaintOrder(order: 1, child: ...), // second painted
    ..., // first painted
  ],
);
```

Higher orders are painted later, so the red box appears above the blue box where they overlap. Children without `PaintOrder` default to `0`.

equal orders preserve the original child order. Hit testing follows reverse paint order.
