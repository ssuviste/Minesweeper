import UIKit

@IBDesignable
class UIBoardButton: UIButton {
    
    private var lineWidth = CGFloat(4)
    
    private var viewMidPoint: CGPoint { return CGPoint(x: bounds.midX, y: bounds.midY) }
    private var viewCircleRadius: CGFloat { return min(bounds.width, bounds.height) / 2 / 3 }
    
    private var viewX1Start: CGPoint { return CGPoint(x: bounds.midX - viewCircleRadius * 1.25, y: bounds.midY - viewCircleRadius * 1.25) }
    private var viewX2Start: CGPoint { return CGPoint(x: bounds.midX - viewCircleRadius * 1.25, y: bounds.midY + viewCircleRadius * 1.25) }
    private var viewX1End: CGPoint { return CGPoint(x: bounds.midX + viewCircleRadius * 1.25, y: bounds.midY + viewCircleRadius * 1.25) }
    private var viewX2End: CGPoint { return CGPoint(x: bounds.midX + viewCircleRadius * 1.25, y: bounds.midY - viewCircleRadius * 1.25) }
    
    private var viewCrossHStart: CGPoint { return CGPoint(x: bounds.midX - viewCircleRadius * 1.75, y: bounds.midY) }
    private var viewCrossVStart: CGPoint { return CGPoint(x: bounds.midX, y: bounds.midY - viewCircleRadius * 1.75) }
    private var viewCrossHEnd: CGPoint { return CGPoint(x: bounds.midX + viewCircleRadius * 1.75, y: bounds.midY) }
    private var viewCrossVEnd: CGPoint { return CGPoint(x: bounds.midX, y: bounds.midY + viewCircleRadius * 1.75) }
    
    private var viewFlagPoleStart: CGPoint { return CGPoint(x: bounds.midX - viewCircleRadius, y: bounds.midY + viewCircleRadius * 1.75) }
    private var viewFlagPoleEnd: CGPoint { return CGPoint(x: bounds.midX - viewCircleRadius, y: bounds.midY - viewCircleRadius * 1.75) }
    private var viewFlag: CGRect { return CGRect(x: bounds.midX - viewCircleRadius + lineWidth / 2,
                                                 y: bounds.midY - viewCircleRadius * 1.75 + lineWidth / 2,
                                                 width: viewCircleRadius * 2 - lineWidth / 2,
                                                 height: viewCircleRadius * 1.75 - lineWidth / 2) }
    
    @IBInspectable
    var btnColor: UIColor = C.btnBgColor
    @IBInspectable
    var btnPressedColor: UIColor = C.btnPressedBgColor
    @IBInspectable
    var textColor: UIColor = C.textColor
    @IBInspectable
    var mineColor: UIColor = C.themeT1MineColor
    @IBInspectable
    var flagColor: UIColor = C.themeT1FlagColor
    @IBInspectable
    var cornerR: Int = 5
    
    @IBInspectable
    var isRevealed: Bool = false {didSet {setNeedsDisplay()}}
    @IBInspectable
    var isFlagged: Bool = false {didSet {setNeedsDisplay()}}
    @IBInspectable
    var containsMine: Bool = false
    @IBInspectable
    var adjMinesCount: Int = 0
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layer.backgroundColor = btnColor.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        setTheme()
        self.layer.cornerRadius = CGFloat(cornerR)
        self.layer.borderWidth = 1
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        self.setTitleColor(textColor, for: .normal)
        if isRevealed {
            self.layer.backgroundColor = btnPressedColor.cgColor
            if containsMine {
                let mine = pathForMine()
                mine.stroke()
            } else {
                if adjMinesCount > 0 {
                    self.setTitle("\(adjMinesCount)", for: .normal)
                }
            }
        } else {
            self.layer.backgroundColor = btnColor.cgColor
            self.setTitle("", for: .normal)
            if isFlagged {
                var flag = pathForFlagPole()
                flag.stroke()
                flag = pathForFlag()
                flag.stroke()
            }
        }
    }
    
    private func setTheme() {
        switch Settings.theme {
        case Theme.T2:
            self.mineColor = C.themeT2MineColor
            self.flagColor = C.themeT2FlagColor
        case Theme.T3:
            self.mineColor = C.themeT3MineColor
            self.flagColor = C.themeT3FlagColor
        case Theme.T1:
            break
        }
    }
    
    private func pathForMine() -> UIBezierPath {
        mineColor.set()
        let path = UIBezierPath(arcCenter: viewMidPoint, radius: viewCircleRadius, startAngle: 0.0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        path.lineWidth = lineWidth
        path.fill()
        switch Settings.theme {
        case Theme.T1:
            path.move(to: viewCrossHStart)
            path.addLine(to: viewCrossHEnd)
            path.move(to: viewCrossVStart)
            path.addLine(to: viewCrossVEnd)
        case Theme.T2:
            path.move(to: viewCrossHStart)
            path.addLine(to: viewCrossHEnd)
            path.move(to: viewCrossVStart)
            path.addLine(to: viewCrossVEnd)
            path.move(to: viewX1Start)
            path.addLine(to: viewX1End)
            path.move(to: viewX2Start)
            path.addLine(to: viewX2End)
        case Theme.T3:
            path.move(to: viewX1Start)
            path.addLine(to: viewX1End)
            path.move(to: viewX2Start)
            path.addLine(to: viewX2End)
        }
        return path
    }
    
    private func pathForFlagPole() -> UIBezierPath {
        textColor.set()
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.move(to: viewFlagPoleStart)
        path.addLine(to: viewFlagPoleEnd)
        return path
    }
    
    private func pathForFlag() -> UIBezierPath {
        flagColor.set()
        let path = UIBezierPath(rect: viewFlag)
        path.fill()
        return path
    }
    
}
