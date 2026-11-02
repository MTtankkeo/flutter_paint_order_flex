import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'paint_order_flex.dart';

/// Controls a child paint order without changing its layout position.
///
/// Used by [PaintOrderFlex].
class PaintOrder extends ParentDataWidget<PaintOrderParentData> {
  const PaintOrder({
    super.key,
    required this.order,
    required super.child,
  });

  /// The paint order, Higher values are painted later.
  final int order;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData! as PaintOrderParentData;
    if (parentData.order == order) {
      return;
    }

    parentData.order = order;
    renderObject.parent?.markNeedsPaint();
  }

  @override
  Type get debugTypicalAncestorWidgetClass => PaintOrderFlex;
}

/// Flex layout data with a paint order that defaults to zero.
class PaintOrderParentData extends FlexParentData {
  int order = 0;
}
