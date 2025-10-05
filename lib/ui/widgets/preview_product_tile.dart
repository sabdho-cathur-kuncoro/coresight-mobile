import 'package:flutter/material.dart';
import 'package:coresight/shared/theme.dart';

class PreviewProductTile extends StatefulWidget {
  final String productName;
  final int initialQuantity;
  final ValueChanged<int>? onQuantityChanged;
  final VoidCallback? onDelete; // ✅ Add delete callback

  const PreviewProductTile({
    super.key,
    required this.productName,
    this.initialQuantity = 0,
    this.onQuantityChanged,
    this.onDelete, // ✅ Constructor param
  });

  @override
  State<PreviewProductTile> createState() => _PreviewProductTileState();
}

class _PreviewProductTileState extends State<PreviewProductTile> {
  late int quantity;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
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

          // 🗑 Delete icon
          GestureDetector(
            onTap: widget.onDelete, // ✅ Call delete callback
            child: Container(
              width: 32,
              height: 32,
              margin: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: redColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/icons/ic_bin.png',
                width: 16,
                height: 16,
                color: redColor,
              ),
            ),
          ),

          // ➖ Quantity controls ➕
          Row(
            children: [
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
    );
  }
}
