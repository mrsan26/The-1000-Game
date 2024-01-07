//
//  StatisticController.swift
//  The 1000 Game
//
//  Created by Sanchez on 08.01.2024.
//

import UIKit
import Combine
import DGCharts

class StatisticController: BasicPresentController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: StatisticControllerModel
    
    private lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.delegate = self
        return chartView
    }()
    
    var players: [Player]
            
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        makeTitle(text: "Статистика игры")
        setupChartView(players: players)
    }
    
    init(viewModel: StatisticControllerModel, players: [Player]) {
        self.viewModel = viewModel
        self.players = players
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        mainView.addSubview(lineChartView)
    }
    
    private func makeConstraints() {
        lineChartView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview() //.offset(-12)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(self.view.frame.height / 3)
        }
    }
    
    override func binding() {
    }
    
    private func chooseColor(playerIndex: Int) -> NSUIColor {
        let colors: [NSUIColor] = [.blue, .yellow, .cyan, .green, .magenta, .purple, .orange, .brown, .red, .systemBlue]
        guard playerIndex < colors.count else {
            return colors.randomElement()!
        }
        return colors[playerIndex]
    }
    
    private func setupChartView(players: [Player]) {
        var lineChartEntries: [[ChartDataEntry]] = []
        
        for (number, player) in players.enumerated() {
            lineChartEntries.append([])
            for (index, point) in player.pointsHistory.enumerated() {
                lineChartEntries[number].append(ChartDataEntry(x: index.toDouble(), y: point.toDouble()))
            }
        }
        
        var dataSets: [LineChartDataSet] = []
        for (index, entry) in lineChartEntries.enumerated() {
            dataSets.append(LineChartDataSet(entries: entry, label: players[index].name))
            
            dataSets[index].setColor(chooseColor(playerIndex: index))
            dataSets[index].lineWidth = 3
            dataSets[index].mode = .horizontalBezier // сглаживание
            dataSets[index].drawValuesEnabled = false // убираем значения на графике
            dataSets[index].drawCirclesEnabled = false // убираем точки на графике
            dataSets[index].drawFilledEnabled = false // нужно для градиента
            
            // линия при тапе
            dataSets[index].drawHorizontalHighlightIndicatorEnabled = false // оставляем только вертикальную линию
            dataSets[index].highlightLineWidth = 3 // толщина вертикальной линии
            dataSets[index].highlightColor = chooseColor(playerIndex: index) // цвет вертикальной линии
        }
        
        let data = LineChartData(dataSets: dataSets)
        
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9))
        
        lineChartView.data = data
        // отключаем координатную сетку
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        // отключаем подписи к осям
        lineChartView.xAxis.drawLabelsEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        // отключаем легенду
        lineChartView.legend.enabled = true
        lineChartView.legend.orientation = .vertical
        lineChartView.legend.horizontalAlignment = .left
        lineChartView.legend.verticalAlignment = .center
        lineChartView.legend.yEntrySpace = 10
        lineChartView.legend.formToTextSpace = 6
        lineChartView.legend.form = .circle
        lineChartView.legend.formSize = 16
        lineChartView.legend.textColor = .white
        lineChartView.legend.font = NSUIFont(name: "inter-medium", size: 16)!
        // отключаем зум
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        // убираем артефакты вокруг области графика
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.minOffset = 0
    }
}

extension StatisticController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        Vibration.selection.vibrate()
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        Vibration.selection.vibrate()
    }
}
