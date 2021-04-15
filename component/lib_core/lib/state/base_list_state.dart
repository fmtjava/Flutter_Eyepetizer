import 'package:flutter/material.dart';
import 'package:lib_core/model/paging_model.dart';
import 'package:lib_core/viewmodel/paging_list_model.dart';
import 'package:lib_core/widget/provider_widget.dart';
import 'package:lib_ui/widget/loading_container.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//通用分页State封装
abstract class BaseListState<L, M extends PagingListModel<L, PagingModel<L>>,
        T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  M get viewModel; //真实获取数据的仓库

  Widget getContentChild(M model); //真实的分页控件

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<M>(
        model: viewModel,
        onModelInit: (model) {
          model.refresh();
        },
        builder: (context, model, child) {
          return LoadingContainer(
              viewState: model.viewState,
              retry: model.retry,
              child: Container(
                  color: Colors.white,
                  child: SmartRefresher(
                      controller: model.refreshController,
                      onRefresh: model.refresh,
                      onLoading: model.loadMore,
                      enablePullUp: true,
                      child: getContentChild(model))));
        });
  }

  @override
  bool get wantKeepAlive => true;
}
