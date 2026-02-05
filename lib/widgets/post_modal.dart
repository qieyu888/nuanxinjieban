import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../constants/colors.dart';

class PostModal extends StatefulWidget {
  final VoidCallback onClose;
  final Function(String content, String? location, List<String> imagePaths)? onPublish;

  const PostModal({
    super.key,
    required this.onClose,
    this.onPublish,
  });

  @override
  State<PostModal> createState() => _PostModalState();
}

class _PostModalState extends State<PostModal> with SingleTickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  String? _selectedLocation;
  final List<String> _selectedImages = [];
  bool _isPublishing = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _close() async {
    await _animationController.reverse();
    widget.onClose();
  }

  void _selectLocation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '选择位置',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...[
              '大理 · 洱海',
              '成都 · 宽窄巷子',
              '重庆 · 洪崖洞',
              '西藏 · 拉萨',
              '上海 · 外滩',
              '北京 · 故宫',
            ].map((location) {
              return ListTile(
                leading: const Icon(Icons.location_on, color: AppColors.primary),
                title: Text(location),
                onTap: () {
                  setState(() {
                    _selectedLocation = location;
                  });
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _addImage() async {
    if (_selectedImages.length >= 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('最多只能添加9张图片'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    // 显示选择来源对话框
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '选择图片来源',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.primary),
              title: const Text('从相册选择'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: const Text('拍照'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImages.add(image.path);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('图片添加成功'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('图片选择失败: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _publish() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请输入内容'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    setState(() {
      _isPublishing = true;
    });

    // 模拟发布延迟
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      widget.onPublish?.call(_contentController.text.trim(), _selectedLocation, _selectedImages);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('发布成功！'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      _close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _close,
      child: Container(
        color: Colors.black.withValues(alpha: 0.4),
        child: GestureDetector(
          onTap: () {},
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 顶部栏
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: _close,
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.textLight,
                                ),
                              ),
                              const Text(
                                '发布动态',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              GestureDetector(
                                onTap: _isPublishing ? null : _publish,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _isPublishing 
                                        ? AppColors.textLight 
                                        : AppColors.primary,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: _isPublishing ? [] : [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(alpha: 0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: _isPublishing
                                      ? const SizedBox(
                                          width: 56,
                                          height: 16,
                                          child: Center(
                                            child: SizedBox(
                                              width: 12,
                                              height: 12,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Text(
                                          '发布',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // 内容输入框
                          Container(
                            constraints: const BoxConstraints(
                              minHeight: 128,
                              maxHeight: 200,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFED7AA),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextField(
                              controller: _contentController,
                              maxLines: null,
                              maxLength: 500,
                              decoration: const InputDecoration(
                                hintText: '分享你的旅行心情...',
                                hintStyle: TextStyle(
                                  color: AppColors.textLight,
                                ),
                                border: InputBorder.none,
                                counterText: '',
                              ),
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // 图片网格
                          if (_selectedImages.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1,
                                ),
                                itemCount: _selectedImages.length,
                                itemBuilder: (context, index) {
                                  final imagePath = _selectedImages[index];
                                  final isLocalFile = !imagePath.startsWith('http');
                                  
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: isLocalFile
                                            ? Image.file(
                                                File(imagePath),
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    color: AppColors.borderLight,
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      color: AppColors.textLight,
                                                    ),
                                                  );
                                                },
                                              )
                                            : Image.network(
                                                imagePath,
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    color: AppColors.borderLight,
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      color: AppColors.textLight,
                                                    ),
                                                  );
                                                },
                                              ),
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: GestureDetector(
                                          onTap: () => _removeImage(index),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          // 添加图片按钮
                          GestureDetector(
                            onTap: _addImage,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFED7AA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _selectedImages.isEmpty 
                                        ? '添加图片' 
                                        : '添加更多图片 (${_selectedImages.length}/9)',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // 位置选择
                          GestureDetector(
                            onTap: _selectLocation,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _selectedLocation != null 
                                      ? AppColors.primary 
                                      : AppColors.borderLight,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 18,
                                    color: _selectedLocation != null 
                                        ? AppColors.primary 
                                        : AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _selectedLocation ?? '你在哪儿？',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _selectedLocation != null 
                                            ? AppColors.textPrimary 
                                            : AppColors.textSecondary,
                                        fontWeight: _selectedLocation != null 
                                            ? FontWeight.w500 
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  if (_selectedLocation != null)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedLocation = null;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: AppColors.textLight,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
