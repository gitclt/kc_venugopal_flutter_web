import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/data_grid_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/general_exception.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/internet_exceptions_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/popup/common_popup.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/shimmer/shimmer_builder.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/table/table_serch_bar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/subAdmin/subadmin_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controllers/sub_admin_controller.dart';

class SubAdminView extends GetView<SubAdminController> {
  const SubAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fontSize = MediaQuery.of(context).size.width * .008;
    return Scaffold(
        backgroundColor: AppColor.scaffoldBgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(
                title: 'Sub Admin',
                subTitle: 'Home > Master > Sub Admin',
                isAdd: true,
                onClick: () {
                  controller.clear();
                  Get.rootDelegate.toNamed(Routes.ADD_SUBADMIN);
                },
              ),
              20.height,
              Expanded(
                child: LayoutBuilder(builder: (context, s) {
                  return Obx(() {
                    switch (controller.rxRequestStatus.value) {
                      case Status.loading:
                        return ShimmerBuilder(
                          rowCount: 5,
                          sizes: [
                            s.maxWidth * 0.05,
                            s.maxWidth * 0.3,
                            s.maxWidth * 0.055,
                            s.maxWidth * 0.07,
                            s.maxWidth * 0.07,
                          ],
                        ).paddingAll(10);
                      case Status.error:
                        if (controller.error.value == 'No internet') {
                          return InterNetExceptionWidget(
                            onPress: () {
                              controller.getSubAdmins();
                            },
                          );
                        } else {
                          return GeneralExceptionWidget(onPress: () {
                            controller.getSubAdmins();
                          });
                        }
                      case Status.completed:
                        return Obx(
                          () => PageContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TableSerchBar(
                                  size: size,
                                  onSearchChanged: (value) {
                                    controller.searchData(value);
                                  },
                                ),
                                10.height,
                                controller.data.isEmpty
                                    ? Center(child: boldText('No Data Found'))
                                    : Expanded(
                                        child: SfDataGrid(
                                                allowSorting: true,
                                                columnWidthMode:
                                                    ColumnWidthMode.fill,
                                                headerGridLinesVisibility:
                                                    GridLinesVisibility.both,
                                                gridLinesVisibility:
                                                    GridLinesVisibility.both,
                                                isScrollbarAlwaysShown: true,
                                                source: PriorityDataSource(
                                                  dataList: controller.data,
                                                  onEditTap: (index) {
                                                    controller.editClick(
                                                        controller.data[index]);
                                                  },
                                                  onDelTap: (index) async {
                                                    dynamic response =
                                                        await commonDialog(
                                                            title: "Delete",
                                                            subTitle:
                                                                "Are you sure want to delete this item?",
                                                            titleIcon:
                                                                Icons.delete,
                                                            theamColor:
                                                                AppColor.red);
                                                    if (response == true) {
                                                      controller.delete(
                                                          controller
                                                              .data[index].id
                                                              .toString());
                                                    }
                                                  },
                                                ),
                                                columns:
                                                    _buildColumns(fontSize))
                                            .paddingOnly(bottom: 15),
                                      ),
                              ],
                            ),
                          ),
                        );
                    }
                  });
                }),
              )
            ],
          ),
        ));
  }

  List<GridColumn> _buildColumns(
    double fontSize,
  ) {
    return [
      GridColumn(
        allowSorting: false,
        columnName: 'Sl No.',
        width: 90,
        label: Center(child: columnHeaderText('Sl No.')),
        // width: 80,
      ),
      GridColumn(
          columnName: 'Name',
          allowSorting: true,
          label: GridAlignLeft(
            header: 'NAME',
          )),
      GridColumn(
          columnName: 'Username',
          allowSorting: true,
          label: Center(
            child: columnHeaderText('USERNAME'),
          )),
      GridColumn(
          columnName: 'Contact Person',
          label: Center(
            child: columnHeaderText('CONTACT PERSON'),
          )),
      GridColumn(
          columnName: 'Mobile',
          allowSorting: true,
          label: Center(
            child: columnHeaderText('MOBILE NUMBER'),
          )),
      GridColumn(
          columnName: 'Assembly',
          label: Center(
            child: columnHeaderText('ASSEMBLY'),
          )),
      GridColumn(
        allowSorting: false,
        columnName: 'Actions',
        width: 180,
        label: Center(child: columnHeaderText('ACTIONS')),
      ),
    ];
  }
}

class PriorityDataSource extends DataGridSource {
  final List<SubAdminData> dataList;
  final Function(int) onEditTap;
  final Function(int) onDelTap;

  List<DataGridRow> _dataGridRows = [];

  PriorityDataSource({
    required this.dataList,
    required this.onDelTap,
    required this.onEditTap,
  }) {
    _updateDataGridRows();
  }

  void _updateDataGridRows() {
    _dataGridRows = dataList.asMap().entries.map<DataGridRow>((entry) {
      int index = entry.key;
      var item = entry.value;

      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'Sl No.', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: item.name ?? ''),
        DataGridCell<String>(
            columnName: 'Username', value: item.username ?? ''),
        DataGridCell<String>(
            columnName: 'Contact Person', value: item.contactPerson ?? ''),
        DataGridCell<String>(columnName: 'Mobile', value: item.mobile ?? ''),
        DataGridCell<String>(
            columnName: 'Assembly',
            value: item.assemblies!.map((e) => e.assembly).toList().join(',')),
        DataGridCell<Widget>(
            columnName: 'Actions',
            value: DataGridIconContainer(
              bgColor: getBgColor(index),
              dataCell: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmallIconButton(
                    svgIcon: SvgAssets.editIcon,
                    toolmessage: '',
                    onTap: () {
                      onEditTap(index);
                    },
                  ),
                  SmallIconButton(
                    svgIcon: SvgAssets.deleteIcon,
                    toolmessage: '',
                    onTap: () {
                      onDelTap(index);
                    },
                  ),
                ],
              ),
            )),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int index = _dataGridRows.indexOf(row);

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataCell) {
      if (dataCell.value is Widget) {
        return dataCell.value as Widget;
      } else if (dataCell.columnName == "Name") {
        return DataGridContainer(
          dataCell: dataCell.value.toString(),
          bgColor: getBgColor(index),
          alignment: Alignment.centerLeft,
        );
      }
      return DataGridContainer(
        dataCell: dataCell.value.toString(),
        bgColor: getBgColor(index),
      );
    }).toList());
  }
}
