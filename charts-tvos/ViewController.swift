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
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("updateCharts"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "Não há dados para serem exibidos."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.data = chartData
    }
    
    func updateCharts()
    {
        
        barChartView.data?.dataSets[0].entryForXIndex(1)?.value = (barChartView.data?.dataSets[0].entryForXIndex(1)?.value )! + 1
        
        barChartView.notifyDataSetChanged()
        
        NSLog("Chart updated.")
    }
}

