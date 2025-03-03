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
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controllers/priority_controller.dart';

class PriorityView extends GetView<PriorityController> {
  const PriorityView({super.key});
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
                title: 'Priority',
                subTitle: 'Home > Master > Priority',
                isAdd: true,
                onClick: () {
                  Get.rootDelegate.toNamed(Routes.ADD_PRIORITY);
                },
              ),
              20.height,
              Expanded(
                child: LayoutBuilder(builder: (context, s) {
                  return Obx(() {
                    switch (controller.rxRequestStatus.value) {
                      case Status.loading:
                        return ShimmerBuilder(
                          rowCount: 3,
                          sizes: [
                            s.maxWidth * 0.05,
                            s.maxWidth * 0.3,
                            s.maxWidth * 0.055,
                          ],
                        ).paddingAll(10);
                      case Status.error:
                        if (controller.error.value == 'No internet') {
                          return InterNetExceptionWidget(
                            onPress: () {
                              controller.getPriority();
                            },
                          );
                        } else {
                          return GeneralExceptionWidget(onPress: () {
                            controller.getPriority();
                          });
                        }
                      case Status.completed:
                        return Obx(
                          () => PageContainer(
                            child: Column(
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
        label: Center(child: columnHeaderText('NAME')),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'Actions',
        width: 150,
        label: Center(child: columnHeaderText('ACTIONS')),
      ),
    ];
  }
}

class PriorityDataSource extends DataGridSource {
  final List<dynamic> dataList;
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
        DataGridCell<String>(columnName: 'Name', value: item.name.toString()),
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
                      onEditTap(index); // Pass the row index to handle actions
                    },
                  ),
                  SmallIconButton(
                    svgIcon: SvgAssets.deleteIcon,
                    toolmessage: '',
                    onTap: () {
                      onDelTap(index); // Pass the row index to handle actions
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
      }
      return DataGridContainer(
        dataCell: dataCell.value.toString(),
        bgColor: getBgColor(index),
      );
    }).toList());
  }
}
