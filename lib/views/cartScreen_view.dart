// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/payment_screen.dart';

// class Cartscreenview extends StatefulWidget {
//   const Cartscreenview({super.key});

//   @override
//   State<Cartscreenview> createState() => _CartscreenviewState();
// }

// class _CartscreenviewState extends State<Cartscreenview> {
//   Widget cartSummary() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10,
//             offset: Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Text(
//                         "Total: ",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text(
//                         "Rs. ${getTotalPrice().toStringAsFixed(0)}",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       const Text("Shipping Fee: "),
//                       const Text(
//                         "Rs.150",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                           color: Colors.orange,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.to(() => PaymentScreen());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 87, 7, 236),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 12,
//                   ),
//                 ),
//                 child: const Text(
//                   "CheckOut",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void deleteSelectedItems() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Delete Items"),
//         content: const Text("Are you sure you want to delete selected items?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 for (int i = products.length - 1; i >= 0; i--) {
//                   if (isChecked[i] == true) {
//                     products.removeAt(i);
//                     isChecked.removeAt(i);
//                     quantity.removeAt(i);
//                   }
//                 }
//               });
//               Navigator.pop(context);
//             },
//             child: const Text("Delete"),
//           ),
//         ],
//       ),
//     );
//   }

//   // Sample data
//   final List<Map<String, dynamic>> products = [
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.tJQjxbLRRaEt9B4OB546kAHaHw?w=193&h=202&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "Premium Nike Sneakers",
//       "shop": "Nike Store",
//       "currentPrice": 12000,
//       "oldPrice": 15000,
//     },
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.P3Y-J0w1E9u1aFk-Ok-LxgHaHb?w=193&h=194&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "Adidas Ultraboost",
//       "shop": "Adidas Store",
//       "currentPrice": 18000,
//       "oldPrice": 22000,
//     },
//     {
//       "image":
//           "https://th.bing.com/th/id/OIP.qn83e-h0t1cg9wJzQ0ICRgHaHs?w=176&h=182&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3",
//       "name": "A Grade Nepal Jersey",
//       "shop": "Nepal Store",
//       "currentPrice": 9000,
//       "oldPrice": 12000,
//     },
//     {
//       "image":
//           "https://i5.walmartimages.com/seo/TAIAOJING-Womens-Handbags-Casual-Leather-Messenger-Bag-Large-Capacity-Handbag-Fashion-Bag_317c7ab0-780c-4476-baf2-aceaff2b65a3.2cbbebf7c4c0b06e46f83dc08f5e7253.jpeg",
//       "name": "Womens Handbag",
//       "shop": "Nepal Store",
//       "currentPrice": 7000,
//       "oldPrice": 10000,
//     },
//     {
//       "image":
//           "https://tse1.mm.bing.net/th/id/OIP.R3sDWRvUKYroXQlLGD6wcQHaHI?rs=1&pid=ImgDetMain&o=7&rm=3",
//       "name": "Asus Laptop",
//       "shop": "Nepal Store",
//       "currentPrice": 90000,
//       "oldPrice": 100000,
//     },
//   ];

//   late List<bool> isChecked;
//   late List<int> quantity;

//   @override
//   void initState() {
//     super.initState();
//     isChecked = List<bool>.filled(products.length, false, growable: true);
//     quantity = List<int>.filled(products.length, 1, growable: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
//         ),
//         centerTitle: true,
//         title: const Text(
//           "My Cart",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: deleteSelectedItems,
//             icon: const Icon(Icons.delete_outlined, color: Colors.black),
//           ),
//         ],
//       ),

//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.only(bottom: 20),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return cartItem(
//                   index: index,
//                   imageUrl: products[index]["image"]!,
//                   productName: products[index]["name"]!,
//                   shopName: products[index]["shop"]!,
//                   currentPrice: products[index]["currentPrice"].toString(),
//                   oldPrice: products[index]["oldPrice"].toString(),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),

//       bottomNavigationBar: cartSummary(),
//     );
//   }

//   // Reusable Cart Item Widget
//   Widget cartItem({
//     required int index,
//     required String imageUrl,
//     required String productName,
//     required String shopName,
//     required String currentPrice,
//     required String oldPrice,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, right: 20, left: 8),
//       child: Row(
//         children: [
//           Checkbox(
//             value: isChecked[index],
//             onChanged: (value) {
//               setState(() => isChecked[index] = value!);
//             },
//             shape: const CircleBorder(),
//             activeColor: const Color(0xFF6D28FF),
//             checkColor: Colors.white,
//           ),
//           Expanded(
//             child: Card(
//               child: Container(
//                 height: 110,
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(blurRadius: 5, color: Colors.black12),
//                   ],
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         imageUrl,
//                         width: 70,
//                         height: 70,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             productName,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             shopName,
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                           const Spacer(),
//                           Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Rs. ${products[index]["currentPrice"]}",
//                                     style: const TextStyle(
//                                       color: Colors.green,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Rs. ${products[index]["oldPrice"]}",
//                                     style: const TextStyle(
//                                       color: Colors.red,
//                                       decoration: TextDecoration.lineThrough,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Spacer(),
//                               Row(
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         if (quantity[index] > 1) {
//                                           quantity[index]--;
//                                         }
//                                       });
//                                     },
//                                     icon: const Icon(
//                                       Icons.indeterminate_check_box_outlined,
//                                     ),
//                                   ),
//                                   Text(
//                                     quantity[index].toString(),
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       setState(() => quantity[index]++);
//                                     },
//                                     icon: const Icon(Icons.add_box_outlined),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   double getTotalPrice() {
//     double total = 0;
//     for (int i = 0; i < products.length; i++) {
//       if (isChecked[i]) {
//         total += (products[i]["currentPrice"] as int) * quantity[i];
//       }
//     }
//     return total;
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/cart_item_model.dart';
import 'package:shopease/views/payment_screen.dart';
import 'package:shopease/views/product_detail.dart';

class Cartscreenview extends StatefulWidget {
  const Cartscreenview({super.key});

  @override
  State<Cartscreenview> createState() => _CartscreenviewState();
}

class _CartscreenviewState extends State<Cartscreenview> {
  static const Color _primaryColor = Color(0xFF6D28FF);
  static const double _shippingFee = 150;

  bool _isLoading = false;
  bool _isCheckingOut = false;

  final Set<int> _selectedItemIds = <int>{};

  final List<CartItemModel> _items = [
    const CartItemModel(
      id: 101,
      productId: 1,
      name: 'Premium Nike Sneakers',
      shopName: 'Nike Store',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
          '?auto=format&fit=crop&w=600&q=80',
      price: 12000,
      originalPrice: 15000,
      quantity: 1,
      stockQuantity: 10,
      color: 'White',
      size: '9',
    ),
    const CartItemModel(
      id: 102,
      productId: 2,
      name: 'Adidas Ultraboost',
      shopName: 'Adidas Store',
      imageUrl:
          'https://images.unsplash.com/photo-1549298916-b41d501d3772'
          '?auto=format&fit=crop&w=600&q=80',
      price: 18000,
      originalPrice: 22000,
      quantity: 1,
      stockQuantity: 8,
      color: 'Black',
      size: '8',
    ),
  ];

  double get _selectedSubtotal {
    return _items
        .where((item) => _selectedItemIds.contains(item.id))
        .fold(
          0,
          (total, item) => total + item.price * item.quantity,
        );
  }

  double get _total {
    if (_selectedItemIds.isEmpty) return 0;
    return _selectedSubtotal + _shippingFee;
  }

  bool get _areAllSelected {
    return _items.isNotEmpty &&
        _selectedItemIds.length == _items.length;
  }

  Future<void> _loadCart() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // GET /api/cart
      //
      // final response = await cartService.getCart();
      // final data = response.data['data'];
      // Parse according to the backend's final cart response.

      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _toggleSelectAll(bool? selected) {
    setState(() {
      if (selected == true) {
        _selectedItemIds
          ..clear()
          ..addAll(_items.map((item) => item.id));
      } else {
        _selectedItemIds.clear();
      }
    });
  }

  Future<void> _changeQuantity(
    CartItemModel item,
    int newQuantity,
  ) async {
    if (newQuantity < 1 ||
        newQuantity > item.stockQuantity) {
      return;
    }

    final index = _items.indexWhere(
      (element) => element.id == item.id,
    );

    if (index < 0) return;

    final previousItem = _items[index];

    setState(() {
      _items[index] = item.copyWith(
        quantity: newQuantity,
      );
    });

    try {
      // PUT /api/cart/{cart_item_id}
      //
      // Likely payload:
      // {'quantity': newQuantity}
      //
      // Confirm this field with the backend team.
      await Future<void>.delayed(
        const Duration(milliseconds: 250),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _items[index] = previousItem;
      });

      Get.snackbar(
        'Unable to update cart',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> _removeItems(
    Set<int> itemIds,
  ) async {
    if (itemIds.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            itemIds.length == 1
                ? 'Remove item?'
                : 'Remove selected items?',
          ),
          content: const Text(
            'The selected products will be removed from your cart.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;

    final removedItems = _items
        .where((item) => itemIds.contains(item.id))
        .toList();

    setState(() {
      _items.removeWhere(
        (item) => itemIds.contains(item.id),
      );

      _selectedItemIds.removeAll(itemIds);
    });

    try {
      for (final item in removedItems) {
        // DELETE /api/cart/{cart_item_id}
        debugPrint(
          'DELETE /api/cart/${item.id}',
        );
      }

      await Future<void>.delayed(
        const Duration(milliseconds: 400),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _items.addAll(removedItems);
      });
    }
  }

  Future<void> _checkout() async {
    if (_selectedItemIds.isEmpty ||
        _isCheckingOut) {
      Get.snackbar(
        'Select products',
        'Choose at least one product before checkout.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    setState(() {
      _isCheckingOut = true;
    });

    try {
      // POST /api/checkout
      //
      // The collection does not include its request body.
      // It will probably require address_id, payment_method,
      // coupon_code and possibly selected cart item IDs.

      await Future<void>.delayed(
        const Duration(milliseconds: 350),
      );

      if (!mounted) return;

      Get.to(
        () => PaymentScreen(
          amount: _total,
        ),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 250),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          if (_selectedItemIds.isNotEmpty)
            IconButton(
              onPressed: () {
                _removeItems(
                  Set<int>.from(_selectedItemIds),
                );
              },
              tooltip: 'Remove selected',
              icon: const Icon(
                Icons.delete_outline_rounded,
              ),
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _items.isEmpty
                ? _EmptyCartState(
                    onRefresh: _loadCart,
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final horizontalPadding =
                          constraints.maxWidth < 700
                              ? 14.0
                              : 32.0;

                      return RefreshIndicator(
                        onRefresh: _loadCart,
                        child: ListView(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            10,
                            horizontalPadding,
                            150,
                          ),
                          children: [
                            Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 850,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: _areAllSelected,
                                          onChanged: _toggleSelectAll,
                                          activeColor: _primaryColor,
                                        ),
                                        Text(
                                          _areAllSelected
                                              ? 'Deselect all'
                                              : 'Select all',
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight:
                                                FontWeight.w700,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${_items.length} items',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: theme
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ..._items.map(
                                      (item) => _CartItemCard(
                                        item: item,
                                        isSelected:
                                            _selectedItemIds
                                                .contains(item.id),
                                        onSelected: (selected) {
                                          setState(() {
                                            if (selected) {
                                              _selectedItemIds
                                                  .add(item.id);
                                            } else {
                                              _selectedItemIds
                                                  .remove(item.id);
                                            }
                                          });
                                        },
                                        onDecrease: () {
                                          _changeQuantity(
                                            item,
                                            item.quantity - 1,
                                          );
                                        },
                                        onIncrease: () {
                                          _changeQuantity(
                                            item,
                                            item.quantity + 1,
                                          );
                                        },
                                        onRemove: () {
                                          _removeItems(
                                            {item.id},
                                          );
                                        },
                                        onOpen: () {
                                          Get.to(
                                            () => ProductDetail(
                                              productId:
                                                  item.productId,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
      bottomNavigationBar: _items.isEmpty
          ? null
          : _CartSummary(
              subtotal: _selectedSubtotal,
              shippingFee: _selectedItemIds.isEmpty
                  ? 0
                  : _shippingFee,
              total: _total,
              selectedCount:
                  _selectedItemIds.length,
              isLoading: _isCheckingOut,
              onCheckout: _checkout,
            ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onRemove;
  final VoidCallback onOpen;

  const _CartItemCard({
    required this.item,
    required this.isSelected,
    required this.onSelected,
    required this.onDecrease,
    required this.onIncrease,
    required this.onRemove,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                onSelected(value ?? false);
              },
              activeColor: theme.colorScheme.primary,
            ),
            InkWell(
              onTap: onOpen,
              borderRadius: BorderRadius.circular(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  width: 86,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 86,
                      height: 100,
                      color: theme
                          .colorScheme
                          .surfaceContainerHighest,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onRemove,
                        tooltip: 'Remove',
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(
                          Icons.close_rounded,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item.shopName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (item.color != null ||
                      item.size != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      [
                        if (item.color != null)
                          'Color: ${item.color}',
                        if (item.size != null)
                          'Size: ${item.size}',
                      ].join(' • '),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    crossAxisAlignment:
                        WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Rs. ${item.price.toStringAsFixed(0)}',
                        style:
                            theme.textTheme.titleMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (item.originalPrice != null)
                        Text(
                          'Rs. ${item.originalPrice!.toStringAsFixed(0)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme
                                .colorScheme
                                .onSurfaceVariant,
                            decoration:
                                TextDecoration.lineThrough,
                          ),
                        ),
                      _QuantitySelector(
                        quantity: item.quantity,
                        canDecrease: item.quantity > 1,
                        canIncrease:
                            item.quantity < item.stockQuantity,
                        onDecrease: onDecrease,
                        onIncrease: onIncrease,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final bool canDecrease;
  final bool canIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _QuantitySelector({
    required this.quantity,
    required this.canDecrease,
    required this.canIncrease,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: canDecrease ? onDecrease : null,
            visualDensity: VisualDensity.compact,
            iconSize: 18,
            icon: const Icon(Icons.remove_rounded),
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: canIncrease ? onIncrease : null,
            visualDensity: VisualDensity.compact,
            iconSize: 18,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final double subtotal;
  final double shippingFee;
  final double total;
  final int selectedCount;
  final bool isLoading;
  final VoidCallback onCheckout;

  const _CartSummary({
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.selectedCount,
    required this.isLoading,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Material(
        elevation: 12,
        color: theme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            18,
            12,
            18,
            16,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$selectedCount selected',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Rs. ${total.toStringAsFixed(0)}',
                      style:
                          theme.textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF6D28FF),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      selectedCount == 0
                          ? 'Select items to checkout'
                          : 'Subtotal Rs. ${subtotal.toStringAsFixed(0)} + '
                              'shipping Rs. ${shippingFee.toStringAsFixed(0)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              FilledButton(
                onPressed: selectedCount == 0 || isLoading
                    ? null
                    : onCheckout,
                style: FilledButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF6D28FF),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  isLoading ? 'Please wait...' : 'Checkout',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCartState extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const _EmptyCartState({
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: const [
          SizedBox(height: 140),
          Icon(
            Icons.shopping_cart_outlined,
            size: 72,
          ),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Products you add will appear here.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}