// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:charts_common/common.dart' as common
    show
        AxisSpec,
        DateTimeFactory,
        LineRendererConfig,
        Series,
        SeriesRendererConfig,
        TimeSeriesChart;
import 'behaviors/chart_behavior.dart' show ChartBehavior;
import 'behaviors/line_point_highlighter.dart' show LinePointHighlighter;
import 'cartesian_chart.dart' show CartesianChart;
import 'base_chart.dart' show LayoutConfig;
import 'base_chart_state.dart' show BaseChartState;
import 'selection_model_config.dart' show SelectionModelConfig;

class TimeSeriesChart extends CartesianChart<DateTime> {
  final common.DateTimeFactory dateTimeFactory;

  /// Create a [TimeSeriesChart].
  ///
  /// [dateTimeFactory] allows specifying a factory that creates [DateTime] to
  /// be used for the time axis. If none specified, local date time is used.
  TimeSeriesChart(
    List<common.Series<dynamic, DateTime>> seriesList, {
    bool animate,
    Duration animationDuration,
    common.AxisSpec domainAxis,
    common.AxisSpec primaryMeasureAxis,
    common.AxisSpec secondaryMeasureAxis,
    common.LineRendererConfig<DateTime> defaultRenderer,
    List<common.SeriesRendererConfig<DateTime>> customSeriesRenderers,
    List<ChartBehavior> behaviors,
    List<SelectionModelConfig<DateTime>> selectionModels,
    LayoutConfig layoutConfig,
    this.dateTimeFactory,
    bool defaultInteractions: true,
  }) : super(
          seriesList,
          animate: animate,
          animationDuration: animationDuration,
          domainAxis: domainAxis,
          primaryMeasureAxis: primaryMeasureAxis,
          secondaryMeasureAxis: secondaryMeasureAxis,
          defaultRenderer: defaultRenderer,
          customSeriesRenderers: customSeriesRenderers,
          behaviors: behaviors,
          selectionModels: selectionModels,
          layoutConfig: layoutConfig,
          defaultInteractions: defaultInteractions,
        );

  @override
  common.TimeSeriesChart createCommonChart(BaseChartState chartState) {
    // Optionally create primary and secondary measure axes if the chart was
    // configured with them. If no axes were configured, then the chart will
    // use its default types (usually a numeric axis).
    return new common.TimeSeriesChart(
        layoutConfig: layoutConfig?.commonLayoutConfig,
        primaryMeasureAxis: primaryMeasureAxis?.createAxis(),
        secondaryMeasureAxis: secondaryMeasureAxis?.createAxis());
  }

  @override
  void addDefaultInteractions(List<ChartBehavior> behaviors) {
    super.addDefaultInteractions(behaviors);

    behaviors.add(new LinePointHighlighter());
  }
}
