//
//  ViewController.swift
//  charts-tvos
//
//  Created by Rhonan Carneiro on 27/11/15.
//  Copyright © 2015 Segware. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createBarChart()
        createPieChart()
        
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("updateCharts"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createBarChart() {
        barChartView.noDataText = "Não há dados para serem exibidos."
        barChartView.descriptionText = "Novos clientes por mês"
        barChartView.descriptionFont = UIFont(name: "Arial", size: 25)
        barChartView.descriptionTextPosition = CGPoint(x: 400, y: 2)

        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry(value: unitsSold[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        chartDataSet.colors = ChartColorTemplates.colorful()

        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.data = BarChartData(xVals: months, dataSet: chartDataSet)
    }
    
    func createPieChart() {
        pieChartView.noDataText = "Não há dados para serem exibidos."
        pieChartView.descriptionText = "Eventos em aberto no momento"
        pieChartView.descriptionFont = UIFont(name: "Arial", size: 25)
        pieChartView.descriptionTextPosition = CGPoint(x: 400, y: 2)
        
        let types = ["Alarme", "Arme", "Desarme", "Pânico", "Sem controle"]
        let qty = [20.0, 90.0, 10.0, 34.0, 12.0]
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<types.count {
            let dataEntry = ChartDataEntry(value: qty[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = PieChartDataSet(yVals: dataEntries, label: "Eventos")
        chartDataSet.colors = ChartColorTemplates.colorful()

        pieChartView.data = PieChartData(xVals: types, dataSet: chartDataSet);
    }
    
    func updateCharts() {
        // bar chart
        barChartView.data?.dataSets[0].entryForXIndex(1)?.value = (barChartView.data?.dataSets[0].entryForXIndex(1)?.value)! + 1
        barChartView.notifyDataSetChanged()
        
        // line chart
        pieChartView.data?.dataSets[0].entryForXIndex(1)?.value = (pieChartView.data?.dataSets[0].entryForXIndex(1)?.value)! + 1
        pieChartView.notifyDataSetChanged()
        
        NSLog("Charts updated.")
    }
}

