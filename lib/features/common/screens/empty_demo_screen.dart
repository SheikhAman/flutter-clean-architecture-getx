import 'package:flutter/material.dart';
import 'package:flutter_core/core/utils/app_toast.dart';
import 'package:flutter_core/core/widgets/app_empty_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmptyDemoScreen extends StatefulWidget {
  const EmptyDemoScreen({super.key});

  @override
  State<EmptyDemoScreen> createState() => _EmptyDemoScreenState();
}

class _EmptyDemoScreenState extends State<EmptyDemoScreen> {
  final RxBool _showEmptyState = true.obs;
  final RxList<String> _items = <String>[].obs;

  void _populateMockData() {
    _items.assignAll([
      'Clean Architecture Starter Item 1',
      'GetX State Management Item 2',
      'Material 3 Dynamic Theme Item 3',
      'Offline Connectivity Checker Item 4',
    ]);
    _showEmptyState.value = false;
    AppToast.success('Populated 4 sample items');
  }

  void _clearData() {
    _items.clear();
    _showEmptyState.value = true;
    AppToast.info('Cleared list: Empty state active');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty State Demo'),
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                _showEmptyState.value ? Icons.playlist_add : Icons.delete_outline,
              ),
            ),
            tooltip: 'Toggle Empty / Populated',
            onPressed: () {
              if (_showEmptyState.value) {
                _populateMockData();
              } else {
                _clearData();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (_showEmptyState.value) {
            return AppEmptyState(
              icon: Icons.layers_clear_outlined,
              title: 'No Data Records Found',
              message:
                  'This is the production AppEmptyState component. Use it anywhere lists, feeds, or search queries return no data.',
              actionText: 'Load Sample Records',
              onAction: _populateMockData,
            );
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: _items.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(
                    _items[index],
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Tap trash icon in AppBar to see empty state again.',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
