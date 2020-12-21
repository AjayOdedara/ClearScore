//
//  ScoreProgressView.swift
//  ClearScore
//
//  Created by Ajay Odedra on 20/12/20.
//

import UIKit



class ScoreProgressView: UIView {

	override func awakeFromNib() {
		super.awakeFromNib()
		setupView()
		scoreLabel.text = "..."
	}
	
	var headerText: String = DashboardConstants.View.scoreStaticHearderText
	var maxScore: Int = 700
	private var outerLineSpace: CGFloat = 20
	
	var currentProgress: Int = 0 {
		didSet {
			self.setForegroundLayerColorForSafePercent()
		}
	}
	
	public var lineWidth: CGFloat = 5 {
		didSet{
			foregroundLayer.lineWidth = lineWidth
			backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
		}
	}
	
	public var scoreLabelSize: CGFloat = 50 {
		didSet {
			scoreLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
			scoreLabel.textColor = .systemYellow
			scoreLabel.sizeToFit()
			configScoreLabel()
		}
	}
	
	public var safePercent: Int = 100 {
		didSet{
			setForegroundLayerColorForSafePercent()
		}
	}
	
	public func setScore(to scorePercent: Double, score: Int , withAnimation: Bool) {
		
		var progress: Double {
			get {
				if scorePercent > 1 { return 1 }
				else if scorePercent < 0 { return 0 }
				else { return scorePercent }
			}
		}
		
		foregroundLayer.strokeEnd = CGFloat(progress)
		
		if withAnimation {
			let animation = CABasicAnimation(keyPath: "strokeEnd")
			
			animation.fromValue = 0
			animation.toValue = progress
			animation.duration = 2
			foregroundLayer.add(animation, forKey: "foregroundAnimation")
			
		}
		
		var currentTime: Double = 0
		let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) {  [self] (timer) in
			if currentTime >= 2{
				timer.invalidate()
			} else {
				currentTime += 0.05
				let percent = currentTime/2 * 100
				currentProgress = (Int(Double(score) * percent) / 100)
				
				let attributedScoreText = NSMutableAttributedString()
				attributedScoreText.normal("\(headerText)")
				attributedScoreText.medium("\n\(currentProgress)")
				attributedScoreText.normal("\nout of \(maxScore)")
				scoreLabel.attributedText = attributedScoreText
				
				configScoreLabel()
			}
		}
		timer.fire()
		
	}
	
	//MARK: Private
	private var scoreLabel = UILabel()
	private let foregroundLayer = CAShapeLayer()
	private let backgroundLayer = CAShapeLayer()
	
	private var radius: CGFloat {
		get{
			if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
			else { return (self.frame.height - lineWidth)/2 }
		}
	}
	
	private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
	private func makeBar(){
		self.layer.sublayers = nil
		drawBackgroundLayer()
		drawForegroundLayer()
	}
	
	private func drawBackgroundLayer() {
		let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
		self.backgroundLayer.path = path.cgPath
		self.backgroundLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.05).cgColor
		self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 40/100)
		self.backgroundLayer.fillColor = UIColor.clear.cgColor
		self.layer.addSublayer(backgroundLayer)
	}
	
	private func drawForegroundLayer() {
		
		let startAngle = (-CGFloat.pi/2)
		let endAngle = 2 * CGFloat.pi + startAngle
		
		let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
		
		foregroundLayer.lineCap = CAShapeLayerLineCap.round
		foregroundLayer.path = path.cgPath
		foregroundLayer.lineWidth = lineWidth
		foregroundLayer.fillColor = UIColor.clear.cgColor
		foregroundLayer.strokeColor = UIColor.systemYellow.cgColor
		foregroundLayer.strokeEnd = 0
		
		self.layer.addSublayer(foregroundLayer)
	}
	
	private func configScoreLabel() {
		scoreLabel.textAlignment = .center
		scoreLabel.frame = self.frame
		scoreLabel.numberOfLines = 3
		scoreLabel.sizeToFit()
		scoreLabel.center = pathCenter
	}
	
	private func setForegroundLayerColorForSafePercent() {
		if currentProgress >= self.safePercent {
			self.foregroundLayer.strokeColor = UIColor.green.cgColor
		} else {
			self.foregroundLayer.strokeColor = UIColor.systemYellow.cgColor
		}
	}
	
	private func setupView() {
		makeBar()
		setBorder()
		self.addSubview(scoreLabel)
	}
	
	private func setBorder() {
		
		let borderView = UIView(frame: CGRect(x: self.bounds.origin.x - outerLineSpace/2,
											  y: self.bounds.origin.y - outerLineSpace/2,
											  width: self.frame.size.width + outerLineSpace,
											  height: self.frame.size.height + outerLineSpace))
		
		borderView.layer.cornerRadius = borderView.frame.width/2
		borderView.layer.borderWidth = 1.5
		borderView.layer.borderColor = UIColor.lightGray.cgColor
		self.addSubview(borderView)
	}
	
	//Layout Sublayers
	private var layoutDone = false
	override func layoutSublayers(of layer: CALayer) {
		if !layoutDone {
			let tempText = scoreLabel.text
			setupView()
			scoreLabel.text = tempText
			layoutDone = true
		}
	}
	
}
