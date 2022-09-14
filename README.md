# Apple Tree - 집중 타이머

Apple Tree - 나를 발전시키는 소중한 시간

Apple Tree는 스마트폰 중독을 방지하기 위한 앱입니다. 핸드폰의 유혹 속에 빠져 나오지 못하는 이들에게, 핸드폰을 내려놓고 자신의 개발에 온전히 집중할 수 있도록 합니다. 자신을 가꾸며 함께하는 당신의 사과나무를 키워보세요. 사과나무를 많이 가꿀수록, 당신의 미래도 함께 성장해 갈 것입니다.



## 개발 정리 표



| 날짜         | 기능                                         | Link                                                      |
| ------------ | -------------------------------------------- | --------------------------------------------------------- |
| 22.09.12(월) | Circle Progress View / Timer / Calendar 구성 |                                                           |
| 22.09.13(화) | Realm 구축 및 Calendar 아이콘 생성           | Color 참고 사이트 : https://colorhunt.co/palettes/popular |
| 22.09.14(수) |                                              |                                                           |



## 개발 일기

### 22.09.12 (월)

- 첫 화면의 UI 구성 및 시간이 줄어들 때 Circle Progress Bar 게이지가 함께 증가하도록 구현했습니다. (3시간)
- 팝업화면을 구성하고, 지정된 시간이 다 지나면, 팝업 화면이 새로 뜨도록 설정했습니다. (2시간)
- Font를 적용하였습니다. (1시간 30분)
- 네비바 calendar 버튼을 클릭 시 나타나는 화면에 calendar가 뜨도록 구성해주었습니다. (FSCalendar 사용) (1시간)

`

**class** CircularProgress: UIView {

  **fileprivate** **var** progressLayer = CAShapeLayer()

  **fileprivate** **var** tracklayer = CAShapeLayer()

   

  /*

  // Only override draw() if you perform custom drawing.

  // An empty implementation adversely affects performance during animation.

  override func draw(_ rect: CGRect) {

​    // Drawing code

  }

  */

   

  **override** **init**(frame: CGRect) {

​    **super**.init(frame: frame)

​    createCircularPath()

  }

   

  **required** **init**?(coder aDecoder: NSCoder) {

​    **super**.init(coder: aDecoder)

​    createCircularPath()

  }

   

  **var** progressColor:UIColor = UIColor.red {

​    **didSet** {

​      progressLayer.strokeColor = progressColor.cgColor

​    }

  }

   

  **var** trackColor:UIColor = UIColor.white {

​    **didSet** {

​      tracklayer.strokeColor = trackColor.cgColor

​    }

  }

   

  **fileprivate** **func** createCircularPath() {

​    **self**.backgroundColor = UIColor.clear

​    **self**.layer.cornerRadius = **self**.frame.size.width/2.0

​    **let** circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),

​    radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * Double.pi),

​    endAngle: CGFloat(1.5 * Double.pi), clockwise: **true**)

​     

​    tracklayer.path = circlePath.cgPath

​    tracklayer.fillColor = UIColor.clear.cgColor

​    tracklayer.strokeColor = trackColor.cgColor

​    tracklayer.lineWidth = 10.0;

​    tracklayer.strokeEnd = 1.0

​    layer.addSublayer(tracklayer)

​     

​    progressLayer.path = circlePath.cgPath

​    progressLayer.fillColor = UIColor.clear.cgColor

​    progressLayer.strokeColor = progressColor.cgColor

​    progressLayer.lineWidth = 10.0;

​    progressLayer.strokeEnd = 0.0

​    layer.addSublayer(progressLayer)

​     

  }

   

  **func** setProgressWithAnimation(duration: TimeInterval, value: Float) {

​    **let** animation = CABasicAnimation(keyPath: "strokeEnd")

​    animation.duration = duration

​    // Animate from 0 (no circle) to 1 (full circle)

​    animation.fromValue = 0

​    animation.toValue = value

​    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

​    progressLayer.strokeEnd = CGFloat(value)

​    progressLayer.add(animation, forKey: "animateCircle")

  }

}

`

### 22.09.13 (화)

- calendar 안에 icon이 들어갈 수 있게 icon 이미지를 구성해주었습니다. (2시간)
- UI 색상을 전체적으로 변경해주었습니다. Colorhunt 참고 (1시간)
- Realm 구조 설계 및 Repository Pattern으로 구성하였습니다. (1시간)
- Typora를 사용하여 README를 구성하였습니다. (2시간)



### 22.09.14 (수)