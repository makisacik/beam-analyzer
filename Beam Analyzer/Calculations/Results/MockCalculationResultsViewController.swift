//
//  MockCalculationResultsViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 13.04.2023.
//

import UIKit
import Charts

final class MockCalculationResultsViewController: UIViewController {
    
    private var dataEntries: [ChartDataEntry] = []
    private let resultsGraphMarker = ResultsGraphMarker()

    private let resultsGraph: LineChartView = {
        let lineChartView = LineChartView()
        lineChartView.chartDescription.text = "Calculation Result Graph"
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.axisMinimum = -100
        lineChartView.xAxis.axisMaximum = 100
        lineChartView.leftAxis.axisMinimum = -1000
        lineChartView.leftAxis.axisMaximum = 1000
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = true
        lineChartView.dragEnabled = true
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.highlightPerTapEnabled = true
        return lineChartView
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "square.and.arrow.up")?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        self.title = "Calculation results"
        view.backgroundColor = .systemBackground
        resultsGraph.delegate = self
        addResultGraphData()
        view.addSubview(resultsGraph)
        view.addSubview(shareButton)
        
        setupMarker()
    }
    
    private func makeConstraints() {
        resultsGraph.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(200)
        }
        
        shareButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
            make.width.equalTo(35)
        }
    }
    
    private func setupMarker() {
        resultsGraphMarker.chartView = resultsGraph
        resultsGraph.marker = resultsGraphMarker
    }
    
    private func addResultGraphData() {
        // example x^2 graph
        for value in -10000...10000 {
            let xValue = Double(value) * 0.1
            let yValue = pow(Double(xValue), 2)
            let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
            dataEntries.append(dataEntry)
        }
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Y = X^2")

        dataSet.colors = [.label]
        dataSet.lineWidth = 2.0
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = .lightGray.withAlphaComponent(0.5)
        dataSet.fillFormatter = CustomFillFormatter()
        dataSet.drawCirclesEnabled = false
        
        let chartData = LineChartData(dataSet: dataSet)
        resultsGraph.data = chartData
    }
    
}

extension MockCalculationResultsViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        resultsGraphMarker.setValues(xValue: entry.x, yValue: entry.y)
    }
}

class CustomFillFormatter: FillFormatter {
    func getFillLinePosition(dataSet: Charts.LineChartDataSetProtocol, dataProvider: Charts.LineChartDataProvider) -> CGFloat {
        return dataProvider.chartYMax
    }
}
