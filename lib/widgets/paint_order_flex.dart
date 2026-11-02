import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'paint_order.dart';

/// A [Flex] that controls child paint order without changing layout order.
///
/// See Also:
/// - Wrap children with [PaintOrder] to specify their paint order.
/// - Children without [PaintOrder] have a default order of zero.
///
/// Example:
/// ```dart
/// PaintOrderFlex(
///   direction: .vertical,
///   children: [
///     PaintOrder(order: 2, child: ...), // last painted
///     PaintOrder(order: 1, child: ...), // second painted
///     ..., // first painted
///   ],
/// );
/// ```
class PaintOrderFlex extends Flex {
  const PaintOrderFlex({
    super.key,
    required super.direction,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.clipBehavior,
    super.spacing,
    super.children,
  });

  @override
  RenderFlex createRenderObject(BuildContext context) {
    return RenderPaintOrderFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection ?? getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      spacing: spacing,
    );
  }
}

/// A [RenderFlex] that paints children in their specified paint order.
class RenderPaintOrderFlex extends RenderFlex {
  RenderPaintOrderFlex({
    required super.direction,
    required super.mainAxisAlignment,
    required super.mainAxisSize,
    required super.crossAxisAlignment,
    required super.textDirection,
    required super.verticalDirection,
    required super.textBaseline,
    required super.clipBehavior,
    required super.spacing,
  });

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! PaintOrderParentData) {
      child.parentData = PaintOrderParentData();
    }
  }

  /// Returns children in ascending paint order, preserving ties.
  List<RenderBox> get children {
    final children = getChildrenAsList().indexed.toList();

    children.sort((a, b) {
      final aData = a.$2.parentData! as PaintOrderParentData;
      final bData = b.$2.parentData! as PaintOrderParentData;
      final comparison = aData.order.compareTo(bData.order);
      return comparison != 0 ? comparison : a.$1.compareTo(b.$1);
    });

    return [for (final (_, child) in children) child];
  }

  @override
  void defaultPaint(PaintingContext context, Offset offset) {
    for (final child in children) {
      final parentData = child.parentData! as PaintOrderParentData;
      context.paintChild(child, offset + parentData.offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final child in children.reversed) {
      final parentData = child.parentData! as PaintOrderParentData;
      final isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (result, position) => child.hitTest(result, position: position),
      );

      if (isHit) return true;
    }

    return false;
  }
}
