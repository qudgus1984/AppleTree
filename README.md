# Apple Tree - 집중 타이머

Apple Tree - 나를 발전시키는 소중한 시간

Apple Tree는 스마트폰 중독을 방지하기 위한 앱입니다. 핸드폰의 유혹 속에 빠져 나오지 못하는 이들에게, 핸드폰을 내려놓고 자신의 개발에 온전히 집중할 수 있도록 합니다. 자신을 가꾸며 함께하는 당신의 사과나무를 키워보세요. 사과나무를 많이 가꿀수록, 당신의 미래도 함께 성장해 갈 것입니다.



## 개발 정리 표



| 날짜         | 기능                                                         | etc.                                                         |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 22.09.12(월) | Circular Progress View / Timer / Calendar 구성               | Circular Progress 적용                                       |
| 22.09.13(화) | Realm 구축 및 Calendar 아이콘 적용 / Repository 패턴 적용 / UIColor 재설정 | Color 참고 사이트 : https://colorhunt.co/palettes/popular    |
| 22.09.14(수) | Realm 설계 및 Singleton 패턴 사용                            | realm에서 filter 부분 error 발생                             |
| 22.09.15(목) | Realm Date를 활용해 calendar 및 mainVC 이미지 변경 / Setting 화면 구성 | Realm 데이터 접근 부분 및 FSCalendar 메서드 itemFor 부분 error 발생 |



## 개발 일기

### 22.09.12 (월)

- 첫 화면의 UI 구성 및 시간이 줄어들 때 CircularProgress Bar 게이지가 함께 증가하도록 구현
- 팝업화면을 구성하고, 지정된 시간이 다 지나면, 팝업 화면이 새로 뜨도록 설정
- Font를 적용
- 네비바 calendar 버튼을 클릭 시 나타나는 화면에 calendar가 뜨도록 구성(FSCalendar 사용)



#### - 첫 화면의 UI 구성 및 시간이 줄어들 때 CircularProgress Bar 게이지가 함께 증가하도록 구현

Circular Progress Bar 구현

~~~swift
class CircularProgress: UIView {

    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var tracklayer = CAShapeLayer()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    var progressColor:UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor:UIColor = UIColor.white {
        didSet {
            tracklayer.strokeColor = trackColor.cgColor
        }
    }
    
    fileprivate func createCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
        radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * Double.pi),
        endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        tracklayer.path = circlePath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeColor = trackColor.cgColor
        tracklayer.lineWidth = 10.0;
        tracklayer.strokeEnd = 1.0
        layer.addSublayer(tracklayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0;
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
        
    }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateCircle")
    }

}
~~~

#### - 팝업화면을 구성하고, 지정된 시간이 다 지나면, 팝업 화면이 새로 뜨도록 설정

새로운 메서드들을 많이 적용해서 코드가 clean하지 못함 -> 후에 Refactoring 해줄 것. 

~~~swift
@objc func startButtonClickedCountDown() {

        if startButtonBool == true {
            startButtonBool.toggle()
            self.mainview.startButton.setTitle("중지", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (t) in
                self.mainview.settingCount -= 1
                let minutes = self.mainview.settingCount / 60
                let seconds = self.mainview.settingCount % 60
                
                if self.mainview.settingCount > 0 {
                    self.mainview.countTimeLabel.text = String(format: "%02d:%02d", minutes, seconds)
                    self.mainview.countTimeLabel.text = "\(minutes):\(seconds)"
                    self.progress = Float(self.mainview.settingCount) / 1800.0
                    print(self.progress)
                    self.mainview.circularProgressBar.setProgressWithAnimation(duration: 0.0001, value: 1.0 - self.progress)

                } else {
                    self.mainview.countTimeLabel.text = "00:00"
                    self.mainview.startButton.setTitle("완료", for: .normal)
                    self.timer?.invalidate()
                    self.timer = nil
                    self.finishPopupVCAppear()
                    self.mainview.settingCount = 1800
                    self.mainview.countTimeLabel.text = "30:00"          
                }
            }
        } else {
            startButtonBool.toggle()
            self.mainview.startButton.setTitle("시작", for: .normal)
            timer?.invalidate()
            timer = nil
        }
        
    }
~~~



#### - Font를 적용

<img width="300" alt="스크린샷 2022-09-14 오후 8 12 23-3206262" src="https://user-images.githubusercontent.com/81552265/190294340-7128c740-343b-499d-bc39-6ea126334a7f.png">


#### - 네비바 calendar 버튼을 클릭 시 나타나는 화면에 calendar가 뜨도록 구성(FSCalendar 사용)

<img width="300" alt="스크린샷 2022-09-14 오후 7 52 26-3206184" src="https://user-images.githubusercontent.com/81552265/190294423-e3169d19-22b1-4284-8250-9e4e2d8d9359.png">
### 22.09.13 (화)

- UI 색상을 전체적으로 변경 Colorhunt 참고
- calendar 안에 icon이 들어갈 수 있게 icon 이미지를 구성
- Realm 구조 설계 및 Repository Pattern으로 구성
- Typora를 사용하여 README를 구성

color hunt를 사용하여 구성한 색상 조합



#### - UI 색상을 전체적으로 변경 - Colorhunt 참고


<img width="300" alt="스크린샷 2022-09-14 오후 7 49 24-3206245" src="https://user-images.githubusercontent.com/81552265/190294385-012ca3c9-9b0d-4642-a25d-5c05cbe0c975.png">



색 조합을 이용하여 구성한 화면



#### - calendar 안에 icon이 들어갈 수 있게 icon 이미지를 구성

icon을 사용하여 calendar에 넣어주기

~~~swift
func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let seedsImg = resizeImage(image: UIImage(named: "seeds")!, width: 20, height: 20)
        let sproutImg = resizeImage(image: UIImage(named: "sprout")!, width: 20, height: 20)
        let appleImg = resizeImage(image: UIImage(named: "apple")!, width: 20, height: 20)
        let appleTreeImg = resizeImage(image: UIImage(named: "apple-tree")!, width: 20, height: 20)
        switch dateFormatter.string(from: date) {
        case dateFormatter.string(from: Date()):
            return appleImg
        case "2022-09-06":
            return appleTreeImg
        case "2022-09-07":
            return sproutImg
        case "2022-09-08":
            return seedsImg
        default:
            return nil
        }
    }
~~~


<img width="300" alt="스크린샷 2022-09-14 오후 7 52 26-3206184" src="https://user-images.githubusercontent.com/81552265/190294423-e3169d19-22b1-4284-8250-9e4e2d8d9359.png">





#### - Realm 구조 설계 및 Repository Pattern으로 구성

Realm Schema

~~~swift
class AppleTree: Object {
    @Persisted var ATDate: String
    @Persisted var ATTime: Int

    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(ATDate: String, ATTime: Int) {
        self.init()
        self.ATTime = 0
        self.ATDate = ATDate
    }
}
~~~



Repository Pattern

~~~SAS
protocol ATRepositoryType {
    func fetch() -> Results<AppleTree>
    func addItem(item: AppleTree)
    func updateItem(item: AppleTree, appendTime: Int)
}

class ATRepository: ATRepositoryType {
        
    let localRealm = try! Realm()
    
    func fetch() -> Results<AppleTree> {
        return localRealm.objects(AppleTree.self).sorted(byKeyPath: "ATDate", ascending: true)
    }

    
    func addItem(item: AppleTree) {
        try! localRealm.write {
            localRealm.add(item)
        }
    }
    
    func updateItem(item: AppleTree, appendTime: Int) {
        
//        var totalTime = item.ATTime
        var totalTime = item.ATTime
        totalTime += appendTime
        
        try! localRealm.write {
     
            item.ATTime = totalTime
        }
        print("저장되었습니다.", item.ATTime)
    }
}

~~~



### 22.09.14 (수)

- Realm 구조 재설계
- Singleton Pattern을 활용한 DateFormatter 지정
- Realm에 날짜 데이터 및 시간 데이터 저장 구현
- Realm에서 Filter 사용 중 적용 에러 발생 -> 해결



#### - Realm 구조 재설계

ATDate를 Date 타입으로 받으면 같은 날에 데이터 값을 함께 처리하지 못하게 되는 문제 인지 -> String 타입으로 변환

~~~swift
class AppleTree: Object {
    @Persisted var ATDate: String
    @Persisted var ATTime: Int

    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(ATDate: String, ATTime: Int) {
        self.init()
        self.ATTime = ATTime
        self.ATDate = ATDate
    }
}
~~~



#### - Singleton Pattern 활용해 DateFormatter 지정

Realm에 날짜를 넣을 때 똑같은 양식으로 String값을 지정해주어야 하기 때문에 singleton 패턴으로 DateFormatter을 지정

~~~swift
class DateFormatterHelper {
    
    private init() {}
    
    static let Formatter = DateFormatterHelper()
    let dateFormatter = DateFormatter()
    let date = Date()
    
    func formatDate() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var dateStr: String {
        get {
            formatDate()
            return dateFormatter.string(from: date)
        }
    }
}

~~~



#### - Realm에 날짜 데이터 및 시간 데이터 저장 구현

작성하니 간결하지만, 많은 오류들이 있었다. 특히 값에 접근하지 못해 Realm의 ATTime이 add는 되는데 update가 되지 않는 상황이 발생.

해결 방법 : result가 이미 filter된 값이기 때문에 result의 [0]에 접근하여 값을 업데이트 해주었음.

~~~swift
@objc func okButtonClicked() {

        let result = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
      
        if result.isEmpty {
            repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: MainView().settingCount))
        } else {
            self.repository.updateItem(item: result[0], appendTime: MainView().settingCount)

            repository.fetch()

        }
        dismiss(animated: true)
    }
~~~



#### - Realm에서 Filter 사용 중 적용 에러

해결방법 : realm에서 문자열에 접근할 때 filter 영역에서 문자열 보간법으로 접근하면 되는 줄 알았는데, 작은 따옴표를 안에 넣어주어야 한다는 것을 깨달았다.

~~~swift
repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
~~~



### 22.09.15 (목)

- Realm 의 Time을 가지고 Calendar의 날짜에 icon 삽입
- Realm의 Time을 가지고 Calendar의 subtitle에 시간 삽입
- calendarVC TableViewCell label 설정
- Realm의 Time을 가지고 MainVC의 image를 변경
- Setting UI 화면 구성
- TimeSetting UI 화면 구성

#### - Realm 의 Time을 가지고 Calendar의 날짜에 icon 삽입

겪은 문제 : 처음 calendar에 itemFor 안에 임의의 값을 넣어주었을 때의 코드

~~~swift

let seedsImg = resizeImage(image: UIImage(named: "seeds")!, width: 20, height: 20)
let sproutImg = resizeImage(image: UIImage(named: "sprout")!, width: 20, height: 20)
let appleImg = resizeImage(image: UIImage(named: "apple")!, width: 20, height: 20)
let appleTreeImg = resizeImage(image: UIImage(named: "apple-tree")!, width: 20, height: 20)

switch dateFormatter.string(from: date) {
case dateFormatter.string(from: Date()):
		return appleImg
case "2022-09-06":
		return appleTreeImg
case "2022-09-07":
		return sproutImg
case "2022-09-08":
		return seedsImg
	default:
		return nil
	}
~~~

이렇게 이미지를 설정한 값을 상수에 저장하고, switch 문으로 각각의 해당하는 날짜에 값을 넣어주는 형태로 작성하였음. 이 부분을 이제 Realm의 Time에 접근하여 넣어주면 되겠구나 하고 다음 코드를 작성



~~~swift
func dateChangedIcon(time: Int) -> UIImage? {
        let seedsImg = resizeImage(image: UIImage(named: "seeds")!, width: 20, height: 20)
        let sproutImg = resizeImage(image: UIImage(named: "sprout")!, width: 20, height: 20)
        let appleImg = resizeImage(image: UIImage(named: "apple")!, width: 20, height: 20)
        let appleTreeImg = resizeImage(image: UIImage(named: "apple-tree")!, width: 20, height: 20)
        
        switch time {
        case 0...200:
            return seedsImg
        case 201...410:
            return sproutImg
        case 411...511:
            return appleImg
        case 512...6400:
            return appleTreeImg
        default:
            return nil
        }
    }
~~~

먼저 이렇게 time의 값을 입력받으면 UIImage로 내뱉는 함수를 만들어 주었음.

그리고 itemFor 영역에 각 time에 해당하는 이미지를 뿌려주기 위해 코드 작성

~~~swift
for i in 0...tasks.count {
	switch dateFormatter.string(from: date) {
	case tasks[i].ATDate:
			print(tasks[i].ATTime)
			let img = dateChangedIcon(time: tasks[i].ATTime)
			return img
	default:
		return nil
		}
	}

~~~

for문을 통해 tasks에 접근해서 모든 Realm에 있는 날짜 정보를 switch case 구문을 통해 각 itemFor에 넣어주면 된다고 생각했고, 스스로 오 한번에 잘 생각해냈는데?! 라고 감탄하고 실행을 눌러보니 itemFor에 return값을 작성하라는 오류 메세지가 나타남.

-> 이때부터 멘붕 시작...

오류가 뜨고나서 다시금 코드를 봐보니 for문을 통해 접근하면 결국 return 값은 for문의 {} 영역이기 때문에 하나만 존재함.

그래서 for문을 사용하지 말고 하면 되겠네~! 라고 생각하고 다시 생각 => ... 한시간 뒤... => 반복문을 안돌면 어떻게 접근하냐...?...



- 해결방법 : 배열을 만들어 준 뒤 contains 함수를 통해 데이터를 뿌려주자!!

~~~swift
var dateArr: [String] = []

	for i in 0...tasks.count-1 {
		dateArr.append(tasks[i].ATDate)
			if dateArr.contains(dateFormatter.string(from: date)) {
				return dateChangedIcon(time: tasks[i].ATTime)
			}
		}
	return nil
~~~

- 해결방법 : 고차함수 filter 를 사용해 데이터를 판단하자!!

~~~swift
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"
var filterData = tasks.filter ( "ATDate == '\(dateFormatter.string(from: date))'")
return filterData.isEmpty ? UIImage() : dateChangedIcon(time: filterData[0].ATTime)
~~~



이렇게 코드로 적어보면 간단한 것 같지만, 배열에 contains으로 접근해서 판단하는 아이디어를 떠올리는게 결코 쉽지 않았음. 같은 스터디원들이 같이 조언을 해 준 덕에 방법을 찾을 수 있었던 것 같음. 그리고 filter로 데이터를 뿌려보면서, 이래서 고차함수를 이러한 영역에서 쓰는구나를 느꼈음. 다음에 이러한 문제가 발생했을 때 고차함수를 바로 떠올리고 적용해보려고 하는 자세가 중요할 것 같음.





#### - Realm의 Time을 가지고 Calendar의 subtitle에 시간 삽입

Calendar에 image를 넣어주면서 삽질을 하니, 이제 관련된 것들은 비슷한 메커니즘으로 이루어지기 때문에 빠르게 진행이 되었음.

calendar의 subtitleFor에 접근하여 코드 작성



~~~swift
func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let test = tasks.filter ( "ATDate == '\(dateFormatter.string(from: date))'")
        return test.isEmpty ? nil : String("\(test[0].ATTime/60):\(test[0].ATTime%60)")
}
~~~
<img width="300" alt="스크린샷 2022-09-15 오후 11 25 12-3251919" src="https://user-images.githubusercontent.com/81552265/190431419-26fef469-2c50-42e5-b7d1-c177304564dd.png">


#### - calendarVC TableViewCell label 설정

- 오늘 집중 타이머를 이용한 시간 보여주기
- 어제와 오늘의 집중 타이머가 가지고있는 시간의 차이를 label에 보여주기
- 이번 달의 사과나무의 개수를 나타내기 (미설정)

위 3개를 tableView에서 보여주고 싶었음. 아직 보여지는 달의 데이터에 접근하는 것까진 구상을 하지 못해 위 2개만 먼저 적용



~~~swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CalendarTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .huntLightGreen
        
        let todayInfo = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
        let yesterdayInfo = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.yesterDayStr)'" )
        
        let hour = todayInfo[0].ATTime / 60
        let minutes = todayInfo[0].ATTime % 60

        let removeNum = todayInfo[0].ATTime - yesterdayInfo[0].ATTime
        let removehour = removeNum / 60
        let removeminutes = removeNum % 60

        switch indexPath.row {
        case 0:
            cell.explainLabel.text = "오늘 \(hour)시간 \(minutes)분 만큼 성장하셨네요"
        case 1:
            if removeNum < 0 {
                cell.explainLabel.text = "어제보다 \(-removehour)시간 \(-removeminutes)분 덜 했어요 😭"
            } else if removeNum > 0 {
                cell.explainLabel.text = "어제보다 \(removehour)시간 \(removeminutes)분 더 나아갔어요! >_<"
            } else {
                cell.explainLabel.text = "한결같은 당신의 꾸준함을 응원합니다 :D"

            }
        case 2:
            cell.explainLabel.text = "이번달의 총 사과나무 개수는 몇개 입니다. (구현 필요)"
        default:
            print()
        }
        return cell
    }
~~~
<img width="300" alt="스크린샷 2022-09-15 오후 11 26 12-3251977" src="https://user-images.githubusercontent.com/81552265/190431362-a2caf198-2f76-41cc-839f-3deb671ff320.png">


#### - Realm의 Time을 가지고 MainVC의 image를 변경

mainVC 에 image를 오늘의 Realm이 가지고 있는 Time에 따라 변경하도록 설정

~~~swift
        let todayInfo = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
        mainview.iconImageView.image =  ChangedImage(time: todayInfo[0].ATTime)
~~~

=> 이 과정에서 ChangedImage를 코드 재사용하는데, 
추후에 extension으로 빼놓거나 protocol로 만들어주어 중복 코드를 구조화시킬 것.

<img width="300" alt="스크린샷 2022-09-15 오후 11 35 33" src="https://user-images.githubusercontent.com/81552265/190432053-55b07958-7f7f-4ba9-8add-72c977ada94f.png">


#### - Setting UI 화면 구성

내일 만들 집중 타이머 시간 설정을 위해 Setting UI 설정

<img width="300" alt="스크린샷 2022-09-15 오후 11 26 51" src="https://user-images.githubusercontent.com/81552265/190431220-994a9687-e3f1-4b21-83fe-c3e2e03ffbc6.png">


#### - TimeSetting UI 화면 구성

SettingUI에서 집중 타이머 시간 셀을 클릭하면 나타나는 UI 화면 구성

<img width="300" alt="스크린샷 2022-09-15 오후 11 27 14-3252039" src="https://user-images.githubusercontent.com/81552265/190431167-f94d3274-d543-48d3-baf2-2770b47cb212.png">
