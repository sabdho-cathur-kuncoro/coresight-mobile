import 'package:flutter/material.dart';
import 'package:coresight/shared/theme.dart';

class ProductTile extends StatefulWidget {
  final String productName;
  final bool initialSelected;
  final int initialQuantity;
  final ValueChanged<bool>? onSelectChanged;
  final ValueChanged<int>? onQuantityChanged;

  const ProductTile({
    super.key,
    required this.productName,
    this.initialSelected = false,
    this.initialQuantity = 0,
    this.onSelectChanged,
    this.onQuantityChanged,
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  late bool isSelected;
  late int quantity;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initialSelected;
    quantity = widget.initialQuantity;
    quantityController = TextEditingController(text: quantity.toString());
  }

  void updateQuantity(int newQty) {
    setState(() {
      quantity = newQty.clamp(0, 9999);
      quantityController.text = quantity.toString();
      widget.onQuantityChanged?.call(quantity);
    });
  }

  void toggleSelected() {
    setState(() {
      isSelected = !isSelected;
      widget.onSelectChanged?.call(isSelected);
    });
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelected,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? blueColor : Colors.transparent,
                border: Border.all(color: strokeColor),
                borderRadius: BorderRadius.circular(6),
              ),
              child: isSelected
                  ? Image.asset(
                      'assets/icons/ic_check.png',
                      width: 16,
                      height: 16,
                      color: whiteColor,
                    )
                  : null,
            ),
            const SizedBox(width: 10),

            // Product name
            Expanded(
              child: Text(
                widget.productName,
                style: blackTextStyle.copyWith(
                  fontSize: h5,
                  fontWeight: semiBold,
                ),
              ),
            ),

            // Quantity controls
            Row(
              children: [
                // Decrement
                GestureDetector(
                  onTap: () {
                    if (quantity > 0) updateQuantity(quantity - 1);
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: strokeColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '-',
                      style: blackTextStyle.copyWith(fontSize: h6),
                    ),
                  ),
                ),

                // Text input
                Container(
                  width: 48,
                  height: 32,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: strokeColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: quantityController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: blackTextStyle.copyWith(fontSize: h6),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (val) {
                      final int? newVal = int.tryParse(val);
                      if (newVal != null && newVal >= 0) {
                        setState(() {
                          quantity = newVal;
                          widget.onQuantityChanged?.call(quantity);
                        });
                      }
                    },
                  ),
                ),

                // Increment
                GestureDetector(
                  onTap: () => updateQuantity(quantity + 1),
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: strokeColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '+',
                      style: blackTextStyle.copyWith(fontSize: h6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
