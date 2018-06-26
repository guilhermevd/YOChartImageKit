import WatchKit


class SpinningDonutChartInterfaceController: BaseInterfaceController {

    override func willActivate() {
        super.willActivate()

        let chart = YOChart.SpinningDonutChart
        let frame = CGRect(x:0, y:0, width:59, height:59)
        let image = chart.drawImage(frame: frame, scale: WKInterfaceDevice.current().screenScale)
        self.imageView.setImage(image)
//        self.imageView.startAnimating()
    }

}
