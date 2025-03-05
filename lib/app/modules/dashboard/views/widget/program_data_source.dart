import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/data_grid_container.dart';
import 'package:kc_venugopal_flutter_web/app/core/globals/date_time_formating.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_view_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProgramDataSource extends DataGridSource {
  final List<CasesData> dataList;

  List<DataGridRow> _dataGridRows = [];

  ProgramDataSource({
    required this.dataList,
  }) {
    _updateDataGridRows();
  }

  void _updateDataGridRows() {
    _dataGridRows = dataList.asMap().entries.map<DataGridRow>((entry) {
      // int index = entry.key;
      var item = entry.value;

      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'NAME', value: item.name ?? ''),
        DataGridCell<String>(
            columnName: 'DATE',
            value: item.date != null
                ? dateFormatString(item.date.toString())
                : ''),
        DataGridCell<String>(
            columnName: 'CATEGORY', value: item.category ?? ''),
        DataGridCell<String>(
            columnName: 'PRIORITY', value: item.priority ?? ''),
        DataGridCell<String>(
            columnName: 'CONTACT PERSON',
            value: item.contactPerson!.isNotEmpty
                ? item.contactPerson!.map((e) => e.contactPerson).join(',')
                : ''),
        DataGridCell<String>(columnName: 'STATUS', value: item.status ?? ''),
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
