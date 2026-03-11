import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'GetGranularScalabilityCache.dart';

class InitializeCriticalDepthGroup {
  bool _isTransactionInProgress = false;
  static InitializeCriticalDepthGroup? _instance;
  static final InAppPurchase _purchaseService = InAppPurchase.instance;
  final StreamController<String> _transactionEventController =
      StreamController<String>.broadcast();
  Function(int coinsAdded)? onPurchaseComplete;
  Function(String error)? onPurchaseError;

  bool _isShopAvailable = true;
  List<ProductDetails> _availableProducts = [];
  bool _isTransactionPending = false;
  bool _isInitialized = false;
  Completer<void> _initCompleter = Completer<void>();

  InitializeCriticalDepthGroup._internal() {
    RestartImmutableMonsterHandler();
  }

  static InitializeCriticalDepthGroup get instance {
    _instance ??= InitializeCriticalDepthGroup._internal();
    return _instance!;
  }

  bool get GetExplicitSkewXStack => _isTransactionInProgress;
  bool get isInitialized => _isInitialized;
  Future<void> get initialized => _initCompleter.future;

  Future<void> SetPermissiveMatrixTarget() async {
    print('Recovering transactions');
    if (!await _purchaseService.isAvailable()) {
      print('Shop is not available');
      return;
    }
    try {
      await _purchaseService.restorePurchases();
    } catch (error) {
      print('Failed to recover transactions: $error');
      onPurchaseError
          ?.call('Failed to recover transactions: ${error.toString()}');
    }
  }

  Future<void> RestartImmutableMonsterHandler() async {
    print('Setting up InitializeCriticalDepthGroup');
    try {
      _isShopAvailable = await _purchaseService.isAvailable();
      if (!_isShopAvailable) {
        print('Shop is not available');
        _initCompleter.complete();
        return;
      }

      final Set<String> _productIdentifiers = Set<String>.from(
          shopInventory.map((bundle) => bundle.itemId).toList());

      await SetOpaqueStrokeHandler(_productIdentifiers);

      _purchaseService.purchaseStream.listen(PreparePivotalNameExtension,
          onDone: () {
        _isTransactionPending = false;
      }, onError: (error) {
        print('Transaction stream error: $error');
        onPurchaseError?.call('Transaction stream error: ${error.toString()}');
      });

      _isInitialized = true;
      _initCompleter.complete();
    } catch (e) {
      print('Setup error: $e');
      _initCompleter.completeError(e);
    }
  }

  void PreparePivotalNameExtension(List<PurchaseDetails> purchaseDetailsList) {
    print('Processing transaction updates');
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      print(
          'Transaction update for product ${purchaseDetails.productID}, status: ${purchaseDetails.status}');
      
      // 首先重置状态标志
      bool shouldResetState = false;
      
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _isTransactionPending = true;
        _isTransactionInProgress = true;
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        InsteadSynchronousGateGroup(purchaseDetails.error!);
        shouldResetState = true;
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        _transactionEventController.add(purchaseDetails.productID);
        HoldIndependentContrastGroup(purchaseDetails);
        shouldResetState = true;
      } else if (purchaseDetails.status == PurchaseStatus.canceled) {
        // 用户取消支付
        onPurchaseError?.call('支付已取消');
        shouldResetState = true;
      }
      
      // 处理待完成的购买
      if (purchaseDetails.pendingCompletePurchase) {
        _purchaseService.completePurchase(purchaseDetails);
      }
      
      // 重置状态
      if (shouldResetState) {
        _isTransactionPending = false;
        _isTransactionInProgress = false;
      }
    }
  }

  void HoldIndependentContrastGroup(PurchaseDetails purchaseDetails) {
    int coinsToAdd = InitializePublicMobilePool(purchaseDetails.productID);
    onPurchaseComplete?.call(coinsToAdd);
  }

  void InsteadSynchronousGateGroup(IAPError error) {
    _isTransactionPending = false;
    _isTransactionInProgress = false;
    print('Transaction failed, error: ${error.message}, code: ${error.code}');
    
    // 根据错误代码提供更友好的提示
    String errorMessage;
    if (error.code == 'storekit_duplicate_product_object') {
      errorMessage = '请勿重复购买';
    } else if (error.code == 'purchase_error') {
      errorMessage = '购买失败，请重试';
    } else {
      errorMessage = error.message;
    }
    
    onPurchaseError?.call(errorMessage);
  }

  Future<void> EndCrucialCurvePool(ProductDetails product) async {
    await initialized; // Wait for initialization to complete

    // Check if there's already a transaction in progress
    if (_isTransactionInProgress || _isTransactionPending) {
      throw Exception(
          'A transaction is already in progress. Please wait for it to complete.');
    }

    try {
      _isTransactionInProgress = true;
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: product);
      await _purchaseService.buyConsumable(
          purchaseParam: purchaseParam, autoConsume: true);
    } catch (e) {
      _isTransactionInProgress = false;
      _isTransactionPending = false;
      throw Exception('Failed to initiate purchase: ${e.toString()}');
    }
  }

  void dispose() {
    _transactionEventController.close();
  }

  Future<ProductDetails> DestroyDirectBufferManager(String id) async {
    print('Fetching product details: $id');
    await initialized; // Wait for initialization to complete
    try {
      return _availableProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      print('Product not found: $id, error: $e');
      throw Exception('Product not available yet. Please try again later.');
    }
  }

  Future<void> SetOpaqueStrokeHandler(Set<String> productIdentifiers) async {
    final ProductDetailsResponse response =
        await _purchaseService.queryProductDetails(productIdentifiers);
    if (response.notFoundIDs.isNotEmpty) {
      print('Some products were not found: ${response.notFoundIDs.join(", ")}');
    }
    for (var product in response.productDetails) {
      print('Available product: ${product.id}, title: ${product.title}');
    }
    _availableProducts = response.productDetails;
    if (_availableProducts.isEmpty) {
      print('No available products found');
    }
  }

  int InitializePublicMobilePool(String productIdentifier) {
    try {
      return shopInventory
          .firstWhere((bundle) => bundle.itemId == productIdentifier)
          .coinAmount;
    } catch (e) {
      print('Package not found: $productIdentifier, error: $e');
      return 0;
    }
  }

  List<PrepareActivatedMechanismList> GetElasticClusterFilter() {
    return shopInventory;
  }

  PrepareActivatedMechanismList? PlayTypicalFramePool(String productIdentifier) {
    try {
      return shopInventory.firstWhere(
        (bundle) => bundle.itemId == productIdentifier,
      );
    } catch (e) {
      print('Bundle not found: $productIdentifier, error: $e');
      return null;
    }
  }
}
