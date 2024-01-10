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
    
    private lazy var tableTitleView = TableTitleView()
    
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
    
    var players: [Player]
    var xEntry: Int = 0
            
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        makeTitle(text: "Статистика игры")
        setupChartView(players: players)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lightBackgroundMode()
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
        mainView.addSubview(tableTitleView)
        mainView.addSubview(lineChartView)
        mainView.addSubview(historyTableView)
    }
    
    private func makeConstraints() {
        tableTitleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(historyTableView.snp.top).offset(-8)
        }
        
        historyTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(lineChartView.snp.top).offset(-8)
        }
        
        lineChartView.snp.makeConstraints { make in
            make.leading.equalToSuperview() //.offset(10)
            make.trailing.equalToSuperview() //.offset(-12)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(self.view.frame.height / 3)
        }
    }
    
    override func binding() {
        self.tableTitleView.turnNumberLabel.setViewModel(viewModel.turnNumberLabelVM)
        self.tableTitleView.pointsNumberLabel.setViewModel(viewModel.pointsNumberLabelVM)
        self.tableTitleView.pointsChangesNumberLabel.setViewModel(viewModel.pointsChangesNumberLabelVM)
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
            
            dataSets[index].drawHorizontalHighlightIndicatorEnabled = false // оставляем только вертикальную линию
            dataSets[index].highlightLineWidth = 3 // толщина вертикальной линии
            dataSets[index].highlightColor = .white // цвет вертикальной линии
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
        lineChartView.legend.orientation = .horizontal
        lineChartView.legend.horizontalAlignment = .center
        lineChartView.legend.verticalAlignment = .bottom
        lineChartView.legend.yEntrySpace = 6
        lineChartView.legend.xEntrySpace = 12
        lineChartView.legend.formToTextSpace = 6
        lineChartView.legend.form = .circle
        lineChartView.legend.formSize = 16
        lineChartView.legend.textColor = .white
        lineChartView.legend.font = NSUIFont(name: "robotrondotmatrix", size: 16)!
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
        xEntry = entry.x.toInt()
        historyTableView.reloadData()
        Vibration.selection.vibrate()
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        Vibration.selection.vibrate()
    }
}

extension StatisticController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell<HistoryCellView>.self), for: indexPath)
        guard let historyCell = cell as? BasicTableCell<HistoryCellView> else { return UITableViewCell() }
        
        historyCell.mainView.setInfo(
            turnNumber: xEntry + 1,
            points: 
                doesObjectExist(index: xEntry, in: players[indexPath.row].pointsHistory) ?
                players[indexPath.row].pointsHistory[xEntry] :
                players[indexPath.row].pointsHistory.last!,
            changesPoints:
                doesObjectExist(index: xEntry, in: players[indexPath.row].changesPointsHistory) ?
                players[indexPath.row].changesPointsHistory[xEntry] :
                nil,
            actions: 
                doesObjectExist(index: xEntry, in: players[indexPath.row].actionsHistory) ?
                players[indexPath.row].actionsHistory[xEntry] :
                nil,
            playerName: players[indexPath.row].name
        )
        
        return historyCell
    }
}
