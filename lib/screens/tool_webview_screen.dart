import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../config/app_colors.dart';
import '../models/tool_model.dart';

class ToolWebViewScreen extends StatefulWidget {
  final ToolModel tool;

  const ToolWebViewScreen({super.key, required this.tool});

  @override
  State<ToolWebViewScreen> createState() => _ToolWebViewScreenState();
}

class _ToolWebViewScreenState extends State<ToolWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _canGoBack = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) async {
            setState(() => _isLoading = false);
            _canGoBack = await _controller.canGoBack();
          },
          onWebResourceError: (error) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.tool.webUrl));
  }

  Future<void> _refresh() async {
    await _controller.reload();
  }

  Future<void> _handleBackNavigation() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    } else {
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _handleBackNavigation();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.tool.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'app.marketingtool.pro',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            if (_canGoBack)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white70),
                onPressed: () => _controller.goBack(),
              ),
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white70),
              onPressed: _refresh,
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Container(
                color: AppColors.background,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                        strokeWidth: 3,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Loading ${widget.tool.name}...',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
