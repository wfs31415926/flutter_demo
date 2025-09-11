// 埋点
/**
 * tab栏的埋点参数统一为  String title
 * 筛选弹窗的埋点参数统一为 List<String> type 
*/

class EventConstant {
  /// ---------- 工作台-常用功能 ----------
  /// 编辑
  static const String event_commonly_edit = "commonly_edit";

  /// 常用功能设置中的+号按钮
  static const String event_commonly_add = "commonly_add";

  /// ---------- 工作台-消息 ----------
  /// 消息置顶开关
  static const String event_message_top = "message_top";

  /// 消息免打扰开关
  static const String event_no_message_prompt = "no_message_prompt";

  /// ----------待我审批----------
  /// 待我审批（应用按钮）
  static const String event_pending_approval = "pending_approval";

  /// 输入申请人姓名的搜索按钮
  static const String event_pending_approval_name_search =
      "pending_approval_name_search";

  /// 筛选按钮
  static const String event_pending_approval_search_button =
      "pending_approval_search_button";

  /// 筛选框中使用各个筛选条件的次数，通过点击确定按钮后的传参统计
  static const String event_pending_approval_search_condition =
      "pending_approval_search_condition";

  /// 列表页面中的驳回按钮
  static const String event_pending_approval_disagree_list =
      "pending_approval_disagree_list";

  /// 列表页面中的通过按钮
  static const String event_pending_approval_agree_list =
      "pending_approval_agree_list";

  /// 详情页面中的驳回按钮
  static const String event_pending_approval_disagree_details =
      "pending_approval_disagree_details";

  /// 详情页面中的通过按钮
  static const String event_pending_approval_agree_details =
      "pending_approval_agree_details";

  /// ---------- 我发起的 ----------
  /// 我发起的（应用按钮）
  static const String event_initiated = "initiated";

  /// 输入申请人姓名的搜索按钮
  static const String event_initiated_name_search = "initiated_name_search";

  /// 筛选按钮
  static const String event_initiated_search_button = "initiated_search_button";

  /// 全部、通过、审批中、驳回、撤回，各个状态的搜索次数
  static const String event_initiated_search_state = "initiated_search_state";

  /// 筛选框中使用各个筛选条件的次数，通过点击确定按钮后的传参统计
  static const String event_initiated_search_condition = "initiated_search_condition";

  /// ---------- 已审批 ----------
  /// 已审批（应用按钮）
  static const String event_approved = "approved";

  /// 输入申请人姓名的搜索按钮
  static const String event_approved_name_search = "approved_name_search";

  /// 筛选按钮
  static const String event_approved_search_button = "approved_search_button";

  /// 全部、驳回、撤回，各个状态的搜索次数
  static const String event_approved_search_state = "approved_search_state";

  /// 筛选框中使用各个筛选条件的次数，通过点击确定按钮后的传参统计
  static const String event_approved_search_condition = "approved_search_condition";

  /// ---------- 合同签订 ----------
  /// 合同签订（应用按钮）
  static const String event_contract_signing = "contract_signing";

  /// 发起申请页面的暂存按钮
  static const String event_contract_signing_storage_addpage =
      "contract_signing_storage_addpage";

  /// ---------- 合同调价 ----------
  /// 合同调价（应用按钮）
  static const String event_contract_price = "contract_price";

  /// 发起申请页面的暂存按钮
  static const String event_contract_price_storage_addpage =
      "contract_price_storage_addpage";

  /// ---------- 合同增补 ----------
  /// 合同增补（应用按钮）
  static const String event_contract_supplement = "contract_supplement";

  /// 发起申请页面的暂存按钮
  static const String event_contract_supplement_storage_addpage =
      "contract_supplement_storage_addpage";

  /// ---------- 计划上报 ----------
  /// 计划上报（应用按钮）
  static const String event_plan_submission = "plan_submission";

  /// 发起申请页面的暂存按钮
  static const String event_plan_submission_storage_addpage =
      "plan_submission_storage_addpage";

  /// ---------- 销售下单 ----------
  /// 销售下单（应用按钮）
  static const String event_sales_order = "sales_order";

  /// 输入订单号的搜索按钮
  static const String event_sales_order_name_search = "sales_order_name_search";

  /// 全部、进行中、已完成，各个状态的搜索次数
  static const String event_sales_order_search_state = "sales_order_search_state";

  /// 筛选按钮
  static const String event_sales_order_search_button = "sales_order_search_button";

  /// 筛选框中使用各个筛选条件的次数，通过点击确定按钮后的传参统计
  static const String event_sales_order_search_condition =
      "sales_order_search_condition";

  /// 运输详情
  static const String event_sales_order_transportation_details =
      "sales_order_transportation_details";

  /// 上传运输证
  static const String event_sales_order_upload_trancert =
      "sales_order_upload_trancert";

  /// 上传购买证
  static const String event_sales_order_upload_buycert = "sales_order_upload_buycert";

  /// 作废
  static const String event_sales_order_void_list = "sales_order_void_list";

  /// 确认签收
  static const String event_sales_order_confirm_receipt =
      "sales_order_confirm_receipt";

  /// 申请售后
  static const String event_sales_order_apply_aftersales =
      "sales_order_apply_aftersales";

  /// 售后详情
  static const String event_sales_order_aftersales_details =
      "sales_order_aftersales_details";

  /// 重新下单
  static const String event_sales_order_reorder = "sales_order_reorder";

  /// ---------- 客户下单 ----------
  /// 客户下单（应用按钮）
  static const String event_customer_order = "customer_order";

  /// ---------- 客诉处理 ----------
  /// 客诉处理（应用按钮）
  static const String event_customer_complaints = "customer_complaints";

  /// 输入客诉单号的搜索按钮
  static const String event_customer_complaints_id_search =
      "customer_complaints_id_search";

  /// 全部、处理中、已处理，各个状态的搜索次数
  static const String event_customer_complaints_search_state =
      "customer_complaints_search_state";

  /// 筛选按钮
  static const String event_customer_complaints_search_button =
      "customer_complaints_search_button";

  /// 筛选框中使用各个筛选条件的次数，通过点击确定按钮后的传参统计
  static const String event_customer_complaints_search_condition =
      "customer_complaints_search_condition";

  /// ---------- 售后申请 ----------
  /// 售后申请（应用按钮）
  static const String event_after_sales = "after_sales";

  /// 输入客诉单号的搜索按钮
  static const String event_after_sales_id_search = "after_sales_id_search";

  /// 全部、待处理、处理中、已处理，各个状态的搜索次数
  static const String event_after_sales_search_state = "after_sales_search_state";

  /// 筛选按钮
  static const String event_after_sales_search_button = "after_sales_search_button";

  /// 筛选框中使用各个筛选条件的次数，通过点击确定按钮后的传参统计
  static const String event_after_sales_search_condition =
      "after_sales_search_condition";

  /// 列表的售后评价按钮
  static const String event_after_sales_evaluate_list = "after_sales_evaluate_list";

  /// 详情的去评价按钮
  static const String event_after_sales_evaluate_details =
      "after_sales_evaluate_details";
}
