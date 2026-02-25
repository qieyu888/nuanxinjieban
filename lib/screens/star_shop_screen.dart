import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../warmTripAPI/SetLastUnaryOwner.dart';
import '../warmTripAPI/GetGranularScalabilityCache.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../constants/colors.dart';

class StarShopScreen extends StatefulWidget {
  const StarShopScreen({super.key});

  @override
  State<StarShopScreen> createState() => _StarShopScreenState();
}

class _StarShopScreenState extends State<StarShopScreen>
    with SingleTickerProviderStateMixin {
  int _starBalance = 600;
  final InitializeCriticalDepthGroup _shopManager =
      InitializeCriticalDepthGroup.instance;
  late List<PrepareActivatedMechanismList> _shopItems;
  final Map<String, ProductDetails> _productDetails = {};
  bool _isLoading = true;
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeOut),
    );
    _animationController!.forward();

    _loadStarBalance();
    _shopManager.onPurchaseComplete = _onPurchaseComplete;
    _shopManager.onPurchaseError = _onPurchaseError;
    _shopItems = _shopManager.GetElasticClusterFilter();
    _loadProducts();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> _loadStarBalance() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _starBalance = prefs.getInt('accountGemBalance') ?? 600;
    });
  }

  Future<void> _saveStarBalance() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accountGemBalance', _starBalance);
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _shopManager.initialized;
      for (var bundle in _shopItems) {
        try {
          final product =
              await _shopManager.DestroyDirectBufferManager(bundle.itemId);
          setState(() {
            _productDetails[bundle.itemId] = product;
          });
        } catch (e) {
          // Product not available yet, silently continue
        }
      }
    } catch (e) {
      // Silently fail, don't show error message on page load
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onPurchaseComplete(int purchasedAmount) {
    setState(() {
      _starBalance += purchasedAmount;
      _saveStarBalance();
    });
    _showMessage('成功获得 $purchasedAmount 颗星星！', isSuccess: true);
  }

  void _onPurchaseError(String errorMessage) {
    _showMessage('购买失败: $errorMessage', isSuccess: false);
  }

  void _showMessage(String message, {bool isSuccess = true}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: isSuccess ? Colors.green : Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  Future<void> _handlePurchase(PrepareActivatedMechanismList bundle) async {
    if (_shopManager.GetExplicitSkewXStack) {
      _showMessage('请等待当前交易完成', isSuccess: false);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final product = _productDetails[bundle.itemId];
      if (product == null) {
        _showMessage('商品暂时不可用，请稍后再试', isSuccess: false);
        return;
      }
      await _shopManager.EndCrucialCurvePool(product);
    } catch (e) {
      _showMessage(e.toString(), isSuccess: false);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                      )
                    : _fadeAnimation != null
                        ? FadeTransition(
                            opacity: _fadeAnimation!,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  _buildBalanceCard(),
                                  const SizedBox(height: 32),
                                  _buildShopItems(),
                                  const SizedBox(height: 32),
                                ],
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                _buildBalanceCard(),
                                const SizedBox(height: 32),
                                _buildShopItems(),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            '星星充值',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFB74D),
            Color(0xFFFF9800),
            Color(0xFFF57C00),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9800).withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.stars_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '当前余额',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$_starBalance',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          '颗星星',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShopItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.textPrimary,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                '选择充值套餐',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ..._shopItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: index < _shopItems.length - 1 ? 16 : 0),
              child: _buildShopItemCard(item, index),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildShopItemCard(PrepareActivatedMechanismList bundle, int index) {
    final product = _productDetails[bundle.itemId];
    final bool isAvailable = product != null;
    final bool isProcessing = _shopManager.GetExplicitSkewXStack;
    final String displayPrice = product?.price ?? bundle.price;

    // 不同套餐使用不同的颜色
    final List<List<Color>> gradients = [
      [const Color(0xFF64B5F6), const Color(0xFF42A5F5)], // 蓝色
      [const Color(0xFFBA68C8), const Color(0xFFAB47BC)], // 紫色
      [const Color(0xFFFF8A65), const Color(0xFFFF7043)], // 橙红色
    ];

    final gradient = gradients[index % gradients.length];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradient[1].withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: (isAvailable && !isProcessing)
              ? () => _handlePurchase(bundle)
              : null,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // 左侧图标
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.stars_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(width: 16),
                // 中间信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bundle.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${bundle.coinAmount} 颗星星',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withValues(alpha: 0.95),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          displayPrice,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // 右侧购买按钮
                Opacity(
                  opacity: isAvailable ? 1.0 : 0.5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isAvailable ? Colors.white : Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: isAvailable
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: isProcessing
                        ? SizedBox(
                            width: 40,
                            height: 20,
                            child: Center(
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      gradient[1]),
                                ),
                              ),
                            ),
                          )
                        : Text(
                            '购买',
                            style: TextStyle(
                              color: isAvailable ? gradient[1] : gradient[1].withValues(alpha: 0.5),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
