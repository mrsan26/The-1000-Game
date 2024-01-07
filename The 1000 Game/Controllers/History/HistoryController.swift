//
//  HistoryController.swift
//  The 1000 Game
//
//  Created by Sanchez on 28.11.2023.
//

import Foundation
import UIKit
import Combine
import DGCharts

class HistoryController: BasicPresentController {
    
    var cancellables: Set<AnyCancellable> = []
    let viewModel: HistoryControllerModel
        
    private lazy var tableTitleView = UIView()
    private lazy var turnNumberLabel = BasicLabel(font: .InterBlack, fontSize: 16)
    private lazy var pointsNumberLabel = BasicLabel(font: .InterMedium, fontSize: 16)
    private lazy var pointsChangesNumberLabel = BasicLabel(font: .InterMedium, fontSize: 16)
    
    private lazy var historyTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(
            BasicTableCell<HistoryCellView>.self,
            forCellReuseIdentifier: String(describing: BasicTableCell<HistoryCellView>.self)
        )
        table.allowsSelection = false
        table.backgroundColor = .clear
        table.separatorColor = .white
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    private lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.delegate = self
        return chartView
    }()
    
    var player: Player
    var selectedCellIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        makeLayout()
        makeConstraints()
        setupChartView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lightBackgroundMode()
        historyTableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
    }
    
    init(viewModel: HistoryControllerModel, player: Player) {
        self.viewModel = viewModel
        self.player = player
        super.init()
        self.makeTitle(text: player.name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        mainView.addSubview(tableTitleView)
        
        tableTitleView.addSubview(turnNumberLabel)
        tableTitleView.addSubview(pointsNumberLabel)
        tableTitleView.addSubview(pointsChangesNumberLabel)
        
        mainView.addSubview(historyTableView)
        mainView.addSubview(lineChartView)
    }
    
    private func makeConstraints() {
        tableTitleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(historyTableView.snp.top).offset(-8)
        }
        turnNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        pointsNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        pointsChangesNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
        
        historyTableView.snp.makeConstraints { make in
            make.top.equalTo(tableTitleView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(lineChartView.snp.top) //.offset(-8)
        }
        
        lineChartView.snp.makeConstraints { make in
            make.leading.equalToSuperview() //.offset(12)
            make.trailing.equalToSuperview() //.offset(-12)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.height.equalTo(self.view.frame.height / 4)
        }
    }
    
    //  Функция биндинг отвечает за связывание компонентов со вьюМоделью
    override func binding() {
        self.turnNumberLabel.setViewModel(viewModel.turnNumberLabelVM)
        self.pointsNumberLabel.setViewModel(viewModel.pointsNumberLabelVM)
        self.pointsChangesNumberLabel.setViewModel(viewModel.pointsChangesNumberLabelVM)
    }
    
    private func setupChartView() {
        var lineChartEntries: [ChartDataEntry] = []
        
        for (index, point) in player.pointsHistory.enumerated() {
            lineChartEntries.append(ChartDataEntry(x: index.toDouble(), y: point.toDouble()))
        }
        
        let dataSet = LineChartDataSet(entries: lineChartEntries)
        dataSet.setColor(.white)
        dataSet.lineWidth = 3
        dataSet.mode = .horizontalBezier // сглаживание
        dataSet.drawValuesEnabled = false // убираем значения на графике
        dataSet.drawCirclesEnabled = false // убираем точки на графике
        dataSet.drawFilledEnabled = true // нужно для градиента
        
        // линия при тапе
        dataSet.drawHorizontalHighlightIndicatorEnabled = false // оставляем только вертикальную линию
        dataSet.highlightLineWidth = 3 // толщина вертикальной линии
        dataSet.highlightColor = .white // цвет вертикальной линии
        
        let data = LineChartData(dataSet: dataSet)
        
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
        lineChartView.legend.enabled = false
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

extension HistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.pointsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<HistoryCellView>.self), for: indexPath)
        guard let historyCell = cell as? BasicTableCell<HistoryCellView> else { return UITableViewCell() }
        
        historyCell.mainView.setInfo(
            turnNumber: indexPath.row + 1,
            points: player.pointsHistory[indexPath.row],
            changesPoints:
                doesObjectExist(index: indexPath.row, in: player.changesPointsHistory) ?
                player.changesPointsHistory[indexPath.row] :
                nil,
            actions: doesObjectExist(index: indexPath.row, in: player.actionsHistory) ?
                player.actionsHistory[indexPath.row] :
                nil
        )
        
        if indexPath == selectedCellIndexPath {
            historyCell.mainView.chooseStatus(true)
        }
        
        return historyCell
    }
}

extension HistoryController: ChartViewDelegate {
    
    func deselectCell() {
        guard let selectedCellIndexPath else { return }
        let cell = historyTableView.cellForRow(at: selectedCellIndexPath)
        guard let historyCell = cell as? BasicTableCell<HistoryCellView> else { return }
        
        historyCell.mainView.chooseStatus(false)
        self.selectedCellIndexPath = nil
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if selectedCellIndexPath != nil {
            deselectCell()
        }
        
        selectedCellIndexPath = IndexPath(row: entry.x.toInt(), section: 0)
        historyTableView.scrollToRow(at: selectedCellIndexPath!, at: .middle, animated: true)
        
        let cell = historyTableView.cellForRow(at: IndexPath(row: entry.x.toInt(), section: 0))
        guard let historyCell = cell as? BasicTableCell<HistoryCellView> else { return }
        
        historyCell.mainView.chooseStatus(true)
        Vibration.selection.vibrate()
    }
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        deselectCell()
        Vibration.selection.vibrate()
    }
}
