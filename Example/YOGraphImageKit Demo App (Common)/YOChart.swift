import UIKit
import YOChartImageKit

enum YOChart {
    case DonutChart, SpinningDonutChart, SmoothLineChart, VerticalBarChart, HorizontalBarChart, SolidLineChart
    
    func drawImage(frame: CGRect, scale: CGFloat) -> UIImage {
        switch self {
        case .SolidLineChart:
            let image = YOLineChartImage()
            image.strokeWidth = 4.0
            image.strokeColor = randomColor()
            image.values = (0...10).map { _ in 10 }
            image.smooth = false
            return image.draw(frame, scale: scale)
        case .SmoothLineChart:
            let image = YOLineChartImage()
            image.fillColor = randomColor()
            image.values = (0...10).map { _ in 10 }
            return image.draw(frame, scale: scale)
        case .VerticalBarChart:
            let image = YOBarChartImage()
            image.fillColor = randomColor()
            image.barPadding = 2.0
            image.values = (0..<15).map { _ in 15 }
            return image.draw(frame, scale: scale)
        case .HorizontalBarChart:
            let image = YOBarChartImage()
            image.fillColor = randomColor()
            image.barPadding = 2.0
            image.barStyle = .horizontal
            image.values = (0..<8).map { _ in 8 }
            return image.draw(frame, scale: scale)
        case .DonutChart:
            let image = YODonutChartImage()
            image.donutWidth = 12.0
            image.labelText = ""
            image.labelColor = UIColor.white
            image.values = [5.0, 15.0, 20.0, 30.0, 10.0, 12.0, 18.0]
            //            image.values = [50.0, 50.0]
            let corJurosPos = UIColor(red:0.03, green:0.61, blue:0.93, alpha:1.0)
            let corJurosPre = UIColor(red:0.82, green:0.66, blue:0.40, alpha:1.0)
            let corMultimercado = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
            let corInflacao = UIColor(red:1.00, green:0.85, blue:0.52, alpha:1.0)
            let corRendaVariavel = UIColor(red:0.32, green:0.94, blue:0.77, alpha:1.0)
            let corInternacional = UIColor(red:1.00, green:0.51, blue:0.00, alpha:1.0)
            let corCambial = UIColor(red:0.04, green:0.48, blue:0.82, alpha:1.0)
            image.colors = [corJurosPos, corJurosPre, corMultimercado, corInflacao, corRendaVariavel, corInternacional, corCambial]//(0..<3).map { _ in randomColor() }
            //             image.colors = [corJurosPos, corRendaVariavel]
            return image.draw(frame, scale: scale)
        case .SpinningDonutChart:
            let image = YOSpinningDonutChartImage()
            let size:CGFloat = 100
            image.value = size
            image.donutWidth = 10.0
            image.backgroundColor = UIColor(red:90/255.0, green:84/255.0, blue:71/255.0, alpha:1/1.0)
            image.color = UIColor(red:0.75, green:0.49, blue:0.00, alpha:1.0)
            image.endColor = UIColor(red:1.00, green:0.79, blue:0.33, alpha:1.0)
            image.finalValue = size
            return image.draw(frame, scale: scale)
        }
    }
    
    private func randomColor() -> UIColor {
        let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
        let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
        let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

