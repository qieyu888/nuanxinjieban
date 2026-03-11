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

class _StarShopScreenState extends State<StarShopScreen> with SingleTickerProviderStateMixin {
  int _b = 600;
  final InitializeCriticalDepthGroup _c = InitializeCriticalDepthGroup.instance;
  late List<PrepareActivatedMechanismList> _d;
  final Map<String, ProductDetails> _e = {};
  bool _f = true;
  AnimationController? _g;
  Animation<double>? _h;

  @override
  void initState() {
    super.initState();
    _g = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _h = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _g!, curve: Curves.easeOut),
    );
    _g!.forward();

    _i();
    _c.onPurchaseComplete = _j;
    _c.onPurchaseError = _k;
    _d = _c.GetElasticClusterFilter();
    _l();
  }

  @override
  void dispose() {
    _g?.dispose();
    super.dispose();
  }

  Future<void> _i() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _b = prefs.getInt('accountGemBalance') ?? 600;
    });
  }

  Future<void> _m() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accountGemBalance', _b);
  }

  Future<void> _l() async {
    setState(() {
      _f = true;
    });

    try {
      await _c.initialized;
      for (var bundle in _d) {
        try {
          final product = await _c.DestroyDirectBufferManager(bundle.itemId);
          setState(() {
            _e[bundle.itemId] = product;
          });
        } catch (e) {
          // ignore
        }
      }
    } catch (e) {
      // ignore
    } finally {
      setState(() {
        _f = false;
      });
    }
  }

  void _j(int purchasedAmount) {
    setState(() {
      _b += purchasedAmount;
      _m();
    });
    _n('成功获得 $purchasedAmount 颗星星！', isSuccess: true);
  }

  void _k(String errorMessage) {
    _n('购买失败: $errorMessage', isSuccess: false);
  }

  void _n(String message, {bool isSuccess = true}) {
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

  Future<void> _o(PrepareActivatedMechanismList bundle) async {
    if (_c.GetExplicitSkewXStack) {
      _n('请等待当前交易完成', isSuccess: false);
      return;
    }

    setState(() {
      _f = true;
    });

    try {
      final product = _e[bundle.itemId];
      if (product == null) {
        _n('商品暂时不可用，请稍后再试', isSuccess: false);
        setState(() {
          _f = false;
        });
        return;
      }
      await _c.EndCrucialCurvePool(product);
    } catch (e) {
      _n(e.toString(), isSuccess: false);
    } finally {
      setState(() {
        _f = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              const Color(0xFFF5F5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _p(),
              Expanded(
                child: _f
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                      )
                    : _h != null
                        ? FadeTransition(
                            opacity: _h!,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  const SizedBox(height: 24),
                                  _q(),
                                  const SizedBox(height: 40),
                                  _r(),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(height: 24),
                                _q(),
                                const SizedBox(height: 40),
                                _r(),
                                const SizedBox(height: 40),
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

  Widget _p() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              '星星充值',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xFFFF9800),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '$_b',
                  style: const TextStyle(
                    color: Color(0xFFFF9800),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _q() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFFE082),
                  const Color(0xFFFFB74D),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB74D).withValues(alpha: 0.35),
                  blurRadius: 28,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.stars_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '当前余额',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$_b',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        '颗',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _r() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 20),
            child: Text(
              '选择套餐',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          ..._d.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: index < _d.length - 1 ? 16 : 0),
              child: _s(item, index),
            );
          }),
        ],
      ),
    );
  }

  Widget _s(PrepareActivatedMechanismList bundle, int index) {
    final product = _e[bundle.itemId];
    final bool isAvailable = product != null;
    final bool isProcessing = _c.GetExplicitSkewXStack;
    final String displayPrice = product?.price ?? bundle.price;

    final List<Map<String, dynamic>> t = [
      {
        'gradient': [const Color(0xFF42A5F5), const Color(0xFF1E88E5)],
        'icon': Icons.flash_on,
      },
      {
        'gradient': [const Color(0xFFAB47BC), const Color(0xFF7B1FA2)],
        'icon': Icons.favorite,
      },
      {
        'gradient': [const Color(0xFFFF7043), const Color(0xFFE64A19)],
        'icon': Icons.workspace_premium,
      },
    ];

    final config = t[index % t.length];
    final gradient = config['gradient'] as List<Color>;
    final icon = config['icon'] as IconData;

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
            color: gradient[1].withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: (isAvailable && !isProcessing) ? () => _o(bundle) : null,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bundle.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${bundle.coinAmount} 颗星星',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: isAvailable ? 1.0 : 0.5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isAvailable
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isAvailable
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: isProcessing
                            ? SizedBox(
                                width: 32,
                                height: 16,
                                child: Center(
                                  child: SizedBox(
                                    width: 14,
                                    height: 14,
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
                                  color: isAvailable
                                      ? gradient[1]
                                      : gradient[1].withValues(alpha: 0.5),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          displayPrice,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
