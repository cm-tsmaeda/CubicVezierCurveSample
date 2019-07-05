//
//  ViewController.swift
//  
//  
//  Created by maeda.tasuku on 2019/07/05
//  Copyright © 2019 Classmethod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timingCurveListTableView: UITableView!
    @IBOutlet weak var animationContainerView: UIView!
    
    var timingCurveList: [CubicTimingParametersType]
    var animationSquare: UIView!
    let squareWidth: CGFloat = 44
    var squareY: CGFloat = 0
    var propertyAnimator: UIViewPropertyAnimator?
    
    required init?(coder aDecoder: NSCoder) {
        
        timingCurveList = [
            CubicTimingParametersType.quadIn,
            CubicTimingParametersType.quadIn,
            CubicTimingParametersType.quadOut,
            CubicTimingParametersType.quadInOut,
            CubicTimingParametersType.cubicIn,
            CubicTimingParametersType.cubicOut,
            CubicTimingParametersType.cubicInOut,
            CubicTimingParametersType.quartIn,
            CubicTimingParametersType.quartOut,
            CubicTimingParametersType.quartInOut,
            CubicTimingParametersType.quintIn,
            CubicTimingParametersType.quintOut,
            CubicTimingParametersType.quintInOut,
            CubicTimingParametersType.sineIn,
            CubicTimingParametersType.sineOut,
            CubicTimingParametersType.sineInOut,
            CubicTimingParametersType.expoIn,
            CubicTimingParametersType.expoOut,
            CubicTimingParametersType.expoInOut,
            CubicTimingParametersType.circIn,
            CubicTimingParametersType.circOut,
            CubicTimingParametersType.circInOut
        ]
        animationSquare = UIView(frame: CGRect.zero)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationSquare.backgroundColor = UIColor(hue: 208.0 / 360.0,
                                                  saturation: 76.0 / 100.0,
                                                  brightness: 93.0 / 100.0,
                                                  alpha: 1)
        animationContainerView.addSubview(animationSquare)
        squareY = (80 - squareWidth) / 2
        animationSquare.frame = CGRect(x: 0, y: squareY, width: squareWidth, height: squareWidth)
    }
    
    func startAnimation(timingCurve: CubicTimingParametersType) {
        
        //UIViewPropertyAnimatorをイージングを指定して作成！
        let params = CubicTimingParametersCreator.createParameters(timingType: timingCurve)
        let animator = UIViewPropertyAnimator(duration: 1.0, timingParameters: params)
        
        //アニメーションの内容
        let halfSquareW = squareWidth / 2
        let centerY = squareY + halfSquareW
        animationSquare.center = CGPoint(x: halfSquareW, y: centerY)
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            let screenW = UIScreen.main.bounds.width
            self.animationSquare.center = CGPoint(x: screenW - halfSquareW, y: centerY)
        }
        propertyAnimator = animator
        
        //スタート
        animator.startAnimation()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timingCurveList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "CurveCell"
        var cellOpt = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cellOpt == nil {
            cellOpt = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        let cell = cellOpt!
        let curve = timingCurveList[indexPath.row]
        cell.textLabel?.text = "\(curve)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curve = timingCurveList[indexPath.row]
        startAnimation(timingCurve: curve)
    }
}
