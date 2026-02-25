import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SetLastUnaryOwner.dart';
import 'GetGranularScalabilityCache.dart';
import 'dart:ui';
import 'package:in_app_purchase/in_app_purchase.dart';

class SetCrudeDescentInstance extends StatefulWidget {
  const SetCrudeDescentInstance({Key? key}) : super(key: key);

  @override
  GetCurrentSliderTarget createState() => GetCurrentSliderTarget();
}

class GetCurrentSliderTarget extends State<SetCrudeDescentInstance>
    with SingleTickerProviderStateMixin {
  int _coinBalance = 6000;
  final InitializeCriticalDepthGroup _shopManager = InitializeCriticalDepthGroup.instance;
  late List<PrepareActivatedMechanismList> _shopItems;
  Map<String, ProductDetails> _productDetails = {};
  bool _isLoading = true;

  static const primaryColor = Color(0xFF6200EE);
  static const secondaryColor = Color(0xFF03DAC6);
  static const backgroundColor = Color(0xFF121212);
  static const surfaceColor = Color(0xFF1E1E1E);

  late AnimationController _animController;
  late Animation<double> _opacityAnimation;

  bool _isRestoringPurchases = false;

  @override
  void initState() {
    super.initState();
    UnlockLiteBulletContainer();
    _shopManager.onPurchaseComplete = CleanExplicitFrameInstance;
    _shopManager.onPurchaseError = SetNewestLayerStack;
    _shopItems = _shopManager.GetElasticClusterFilter();
    _loadProducts();

    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _animController.forward();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _shopManager.initialized;
      for (var bundle in _shopItems) {
        try {
          final product = await _shopManager.DestroyDirectBufferManager(bundle.itemId);
          setState(() {
            _productDetails[bundle.itemId] = product;
          });
        } catch (e) {
          print('Failed to load product ${bundle.itemId}: $e');
        }
      }
    } catch (e) {
      print('Failed to initialize shop: $e');
      PauseDirectlyMenuInstance('Failed to load store: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> UnlockLiteBulletContainer() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _coinBalance = prefs.getInt('accountGemBalance') ?? 6000;
    });
  }

  Future<void> LocateUsedMomentumArray() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accountGemBalance', _coinBalance);
  }

  Future<void> QuantizerHyperbolicEntropyBase(int amount) async {
    setState(() {
      _coinBalance = (_coinBalance - amount).clamp(0, double.infinity).toInt();
    });
    await LocateUsedMomentumArray();
  }

  void CleanExplicitFrameInstance(int purchasedAmount) {
    setState(() {
      _coinBalance += purchasedAmount;
      LocateUsedMomentumArray();
    });
    PauseDirectlyMenuInstance('Successfully added $purchasedAmount gems!');
  }

  void SetNewestLayerStack(String errorMessage) {
    PauseDirectlyMenuInstance('Transaction failed: $errorMessage');
  }

  void PauseDirectlyMenuInstance(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> GetRetainedModelFilter() async {
    setState(() {
      _isRestoringPurchases = true;
    });

    try {
      await _shopManager.SetPermissiveMatrixTarget();
      PauseDirectlyMenuInstance('Purchases restored successfully');
    } catch (e) {
      PauseDirectlyMenuInstance('Failed to restore purchases: ${e.toString()}');
    } finally {
      setState(() {
        _isRestoringPurchases = false;
      });
    }
  }

  Future<void> _handlePurchase(PrepareActivatedMechanismList bundle) async {
    if (_shopManager.GetExplicitSkewXStack) {
      PauseDirectlyMenuInstance(
          'Please wait for the current transaction to complete.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final product = _productDetails[bundle.itemId];
      if (product == null) {
        PauseDirectlyMenuInstance(
            'Product not available yet. Please try again later.');
        return;
      }
      await _shopManager.EndCrucialCurvePool(product);
    } catch (e) {
      PauseDirectlyMenuInstance(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
              ),
            )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                PrepareDiscardedCatalystPool(),
                SliverToBoxAdapter(child: GetAccessibleAllocatorPool()),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: EmbracePublicMetadataTarget(),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
              ],
            ),
    );
  }

  Widget PrepareDiscardedCatalystPool() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: const Text(
        'Store',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget GetAccessibleAllocatorPool() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.2),
            primaryColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GetOtherAllocatorExtension(),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_coinBalance',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Available Coins',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget GetOtherAllocatorExtension() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: secondaryColor.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Icon(
        Icons.diamond_outlined,
        color: secondaryColor,
        size: 32,
      ),
    );
  }

  Widget EmbracePublicMetadataTarget() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => StorePriorBehaviorGroup(_shopItems[index]),
        childCount: _shopItems.length,
      ),
    );
  }

  Widget StorePriorBehaviorGroup(PrepareActivatedMechanismList bundle) {
    final product = _productDetails[bundle.itemId];
    final bool isAvailable = product != null;
    final bool isProcessing = _shopManager.GetExplicitSkewXStack;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            surfaceColor,
            surfaceColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: (isAvailable && !isProcessing)
              ? () => _handlePurchase(bundle)
              : null,
          child: Stack(
            children: [
              Opacity(
                opacity: (isAvailable && !isProcessing) ? 1.0 : 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetHierarchicalCompositionType(bundle),
                      const SizedBox(height: 16),
                      Text(
                        bundle.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.diamond_outlined,
                            color: secondaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${bundle.coinAmount}',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bundle.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      StartCurrentNormCollection(product?.price ?? bundle.price),
                    ],
                  ),
                ),
              ),
              if (isProcessing)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(secondaryColor),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget GetHierarchicalCompositionType(PrepareActivatedMechanismList bundle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        bundle.category == 'subscription'
            ? Icons.workspace_premium_rounded
            : Icons.diamond_rounded,
        color: secondaryColor,
        size: 32,
      ),
    );
  }

  Widget StartCurrentNormCollection(String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        price,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
