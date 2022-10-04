# Apple Tree - 집중 타이머

Apple Tree - 나를 발전시키는 소중한 시간

Apple Tree는 스마트폰 중독을 방지하기 위한 앱입니다. 핸드폰의 유혹 속에 빠져 나오지 못하는 이들에게, 핸드폰을 내려놓고 자신의 개발에 온전히 집중할 수 있도록 합니다. 자신을 가꾸며 함께하는 당신의 사과나무를 키워보세요. 사과나무를 많이 가꿀수록, 당신의 미래도 함께 성장해 갈 것입니다.

## 실행 화면

![Simulator Screen Recording - iPhone 13 Pro - 2022-09-17 at 14 09 26](https://user-images.githubusercontent.com/81552265/190841509-61d19ef8-84c7-4290-b830-661db1b7384f.gif)


## 개발 정리 표



| 날짜         | 기능                                                         | etc.                                                         |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 22.09.12(월) | Circular Progress View / Timer / Calendar 구성               | Circular Progress 적용                                       |
| 22.09.13(화) | Realm 구축 및 Calendar 아이콘 적용 / Repository 패턴 적용 / UIColor 재설정 | Color 참고 사이트 : https://colorhunt.co/palettes/popular    |
| 22.09.14(수) | Realm 설계 및 Singleton 패턴 사용                            | realm에서 filter 부분 error 발생                             |
| 22.09.15(목) | Realm Date를 활용해 calendar 및 mainVC 이미지 변경 / Setting 화면 구성 | Realm 데이터 접근 부분 및 FSCalendar 메서드 itemFor 부분 error 발생 |
| 22.09.16(금) | 값 전달(protocol) 이용해 Time 설정                           | 앱 삭제 후 다시 깔았을 때 calendar 접근 시 realm 데이터 없을 때 error 발생 |
| 22.09.17(토) | feedback 기반 으로 Code 구조화                               | Realm filter 부분까지 Repository로 구현                      |
| 22.09.18(일) | background 상태일 때 화면 전환                               | UserDefaults 로 화면 구분 -> 이 방식이 맞나..?               |
| 22.09.19(월) | Thema Update / 화면전환 stack 안쌓이게 전환                  | Thema관련 enum 및 func으로 설정                              |
| 22.09.20(화) | 화면전환시 나타나는 오류 해결 및 기획 수정 / Realm 설계      | 처음 구조를 잘 설계하는 것이 얼마나 중요한지를 느낌          |
| 22.09.21(수) | Coin System 설계 및 로직 구현                                | 총 Coin을 유지시키는 부분에서 error 발생                     |
| 22.09.22(목) | Coin으로 Thema 구입할 수 있도록 설계 및 로직 구현            | Realm 구조에 대해 다시금 생각해보고 재설계 해야할듯..        |
| 22.09.23(금) | 중간발표                                                     | Feedback 적용해보자...                                       |
| 22.09.24(토) | Realm 구조 재설계 - Coin Realm                               | Coin / thema / User table 분리                               |
| 22.09.25(일) | Font 기능 추가 - Font 기능 구조화                            | Font도 thema처럼 테이블 분리!                                |
| 22.09.26(월) | 차트 구성 및 데이터 뿌려주기                                 | 차트가 원하는대로 커스텀이 어려움                            |
| 22.09.27(화) | 아카이빙 공부 및 testFlight 초대 / Calendar label 수정       | 다른 사람들의 앱도 구경하는 경험                             |
| 22.09.28(수) | UI 업데이트 -> Icon Set 설정                                 | 앱 느낌과 비슷한 icon 만들기 - 디자이너의 중요성...          |
| 22.09.29(목) | 화면 쌓임 Error / 첫 심사 제출                               | Reject... Coin에 대한 명시가 필요함...                       |
| 22.09.30(금) | 통계 UI 깨짐 오류 해결 / App 이름 변경                       | grow time -> 직관적으로 이 앱이 무엇인지 알 수 있었음!       |
| 22.10.01(토) | UI 최종 수정 및 앱 출시                                      | 드디어 출시!!! grow time!!                                   |
| 22.10.02(일) | pagination / 추천 코드 입력 창 업데이트                      | Reject... 추천 코드는 리젝사유...                            |
| 22.10.03(월) | 추천코드 기능 제외 재업데이트 및 버그 수정                   | 업데이트 1시간만에 바로!!                                    |
| 22.10.04(화) |                                                              |                                                              |
|              |                                                              |                                                              |



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

### 22.09.16 (금)

- TimeSetting 화면에 원하는 시간 클릭 시 UserDefaults에 저장
- 값 전달을 통해 MainVC에 바로 적용될 수 있도록 변환
- 저장된 UserDefault로 타이머 시간 변경
- 각 이미지 변경하는 함수들 실제 적용 시간으로 변경

#### TimeSetting 화면에 원하는 시간 클릭 시 UserDefaults에 저장

이제 TimeSettingVC에서 각 시간에 대한 Cell 클릭 시 UserDefault에 값이 저장되도록 변환

~~~swift
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            UserDefaults.standard.set(15*60, forKey: "engagedTime")
            print(UserDefaults.standard.integer(forKey: "engagedTime"))
            delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
            let mainViewController = MainViewController()
            transition(mainViewController, transitionStyle: .push)
        case 1:
            UserDefaults.standard.set(30*60, forKey: "engagedTime")
            print(UserDefaults.standard.integer(forKey: "engagedTime"))
            delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
            let mainViewController = MainViewController()
            transition(mainViewController, transitionStyle: .push)
        case 2:
            UserDefaults.standard.set(60*60, forKey: "engagedTime")
            print(UserDefaults.standard.integer(forKey: "engagedTime"))
            delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
            let mainViewController = MainViewController()
            transition(mainViewController, transitionStyle: .push)
        case 3:
            UserDefaults.standard.set(120*60, forKey: "engagedTime")
            print(UserDefaults.standard.integer(forKey: "engagedTime"))
            delegate?.sendSettingTime(UserDefaults.standard.integer(forKey: "engagedTime"))
            let mainViewController = MainViewController()
            transition(mainViewController, transitionStyle: .push)
        default:
            print("error발생")
            
        }
    }
~~~



#### 값 전달을 통해 MainVC에 바로 적용될 수 있도록 변환 및 시간 변경

- 값 전달을 위해 TimeSettingVC에 Protocol 선언

  ~~~swift
  protocol settingTimeDelegate {
      func sendSettingTime(_ time: Int)
  }
  ~~~

- class 내 delegate 선언

  ~~~swift
  var delegate: settingTimeDelegate?
  ~~~

- 값 전달받을 배열 만들기

  ~~~swift
  var getSettingTime: [Int] = []
  ~~~

- MainVC에 extension으로 값 전달 받기

  ~~~swift
  extension MainViewController: settingTimeDelegate {
      func sendSettingTime(_ time: Int) {
          getSettingTime.append(time)
          mainview.settingCount = getSettingTime.startIndex
      }
  }
  ~~~

#### 각 이미지 변경하는 함수들 실제 적용 시간으로 변경

이제 값 설정을 해줬으니, 실제 적용 시간에 따라 이미지가 변화하도록 설정해주어야 함!



~~~swift
    func ChangedImage(time: Int) -> UIImage? {
        
        
        switch time {
        case 0...7200:
            return UIImage(named: "seeds")
        case 7201...14400:
            return UIImage(named: "sprout")
        case 14401...21600:
            return UIImage(named: "apple")
        case 21601...:
            return UIImage(named: "apple-tree")
        default:
            return nil
        }
        
    }
~~~

저장 값을 초에 따라 설정해주었으므로, 2시간 마다 변경하게 끔 초단위로 메서드 변경


![Simulator Screen Recording - iPhone 13 Pro - 2022-09-17 at 14 09 26](https://user-images.githubusercontent.com/81552265/190841509-61d19ef8-84c7-4290-b830-661db1b7384f.gif)



이렇게 잘 실행이 되는 줄 알았으나 앱 삭제 후 다시 실행했을 때 전 날의 비교 Realm 데이터가 없어 calendar에 들어갔을 때 error가 뜨고 앱이 종료되는 현상이 발생...

이 부분에 대해서는 비교할 realm이 없을 때의 예외처리를 해주어야 할 것 같다..!!

내일 이 문제점을 해결해볼 것!!



### 22.09.17 (토)

- Repository Pattern으로 Filter에 대한 코드 구조화
- row한 코드들 refactoring
- 기본 App Setting 및 class 명과 파일 명 일치시키기

#### Repository Pattern으로 Filter에 대한 코드 구조화

~~~swift
 let result = repository.localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.yesterDayStr)'" )
result[0].isEmpty
~~~

이전에는 위와 같이 오늘의 Date가 Realm에 있는지 판단하기 위해 변수에 filter를 대입하고, 변수[0].isEmpty 방식으로 확인하는 코드로 전개하였다. 하지만 이 부분도 repository 방식으로 변환이 가능하다고 피드백받았고, 이를 repository 방식으로 적용해보았다.



~~~swift
func todayFilter() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.dateStr)'" )
        return item
    }
    
    func yesterdayFilter() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATDate == '\(DateFormatterHelper.Formatter.yesterDayStr)'" )
        return item
    }
    
    func appleTreeGrownCount() -> Results<AppleTree> {
        let item = localRealm.objects(AppleTree.self).filter("ATTime >= 21600")
        return item
    }
~~~

Repostiory에 이렇게 작성하고, 실제 적용한 코드

~~~swift
cell.explainLabel.text = "지금까지 성장시킨 사과나무는 총 \(repository.appleTreeGrownCount().count)개 입니다."

let hour = repository.todayFilter()[0].ATTime / 3600
let minutes = repository.todayFilter()[0].ATTime % 3600 / 60
~~~

전반적인 코드를 구조화시키고, 적용해보면서 어떠한 방식이 더욱 유지보수 측면에서 좋은지 생각해보는 계기가 된 것 같다.

#### row한 코드들 refactoring

~~~swift
let weekDictionary: [Int : String] = [0 : "일", 1 : "월", 2 : "화", 3 : "수", 4 : "목", 5 : "금", 6 : "토"]
for i in 0...6 {
	mainview.calendarView.calendarWeekdayView.weekdayLabels[i].text = weekDictionary[i]
}
~~~

6~7줄로 하나하나 작성한 코드를, dictionary 형태로 한줄로 표현했다. 처음부터 이렇게 왜 못짤까.. 흙흙

그리고 tableView의 delegate / datasource 를 관리하는 부분은 계속 반복실행하기 때문에 이 부분에서는 최대한 부담을 주지 않는것이 좋다고, class 부분으로 빼내는 것을 해보라고 feedback 받았다. 막상 적용해보려니까 이것저것 오류가 생겨 다시 코드를 돌려놓았지만, 기능 구현이 되는 대로 다시 수정해볼 것이다!



#### 기본 App Setting 및 class 명과 파일 명 일치시키기

Singleton 패턴으로 구현한 DateFormatter을 파일명을 SingletonDateFormatter이라고 하고, class 명은 DateFormatterHelper 라고 지정해뒀는데, 굳이 파일명을 Singleton을 명시해줄 필요는 없고, 대부분 class명과 파일명은 일치시켜주는 것이 좋다고 피드백 받아 수정하였다.



이 외에도 코드적으로 거슬리는 것들이나 필요없는 주석, 안쓰는 것들에 대한 전반적인 코드를 정리하였고, 내일부터는 다시 기능 구현을 목적으로 다시 코드를 짜볼 것이다.



### 22.09.18 (일)

- ResetPopupView 구성
- Background 상태 시 ResetPopupVC로 전환되도록 설정
- 추가 기능으로 타이머 정지를 3번까지 할 수 있도록 기능 개선
- 타이머 정지 시에는 Background 상태여도 타이머 초기화 및 화면 전환이 되지 않도록 설정
- 위와 관련된 오류에 대해 toast를 사용하여 예외 처리 / 기존 Alert 사용 부분 toast로 전환

#### ResetPopupView 구성
<img width="300" alt="스크린샷 2022-09-18 오후 8 11 21" src="https://user-images.githubusercontent.com/81552265/190899189-dc133c9b-500a-44e2-98dd-0fa7224db88c.png">


위와 같이 Background 상태로 전환 시 나타날 화면을 구성해주었음. 추후 UI 개선때 고민해보고 수정해볼 것.



#### Background 상태 시 ResetPopupVC로 전환되도록 설정

~~~swift
 func sceneDidEnterBackground(_ scene: UIScene) {
	MainViewController().timer?.invalidate()
	MainViewController().timer = nil
	guard let scene = (scene as? UIWindowScene) else { return }
	window = UIWindow(windowScene: scene)
	let rootViewController = ResetPopupViewController()
	let navigationController = UINavigationController(rootViewController: rootViewController)
	window?.rootViewController = navigationController
	window?.makeKeyAndVisible()
}
~~~


![Simulator Screen Recording - iPhone 13 Pro - 2022-09-18 at 19 53 31](https://user-images.githubusercontent.com/81552265/190898992-49616f97-5492-4a7f-aa6f-df6270f74641.gif)




Background로 상태 변환 시 ResetPopupVC로 전환

#### 추가 기능으로 타이머 정지를 3번까지 할 수 있도록 기능 개선

타이머가 진행되는 과정에서 Background로 가게 되면 바로 화면전환이 되는데, 이때 전화가 온다거나 하는 예외 상황에 대해서 처리를 안해주는 것은 사용자 입장에서 너무할 수 있다고 느낄 수 있다고 피드백을 받았음. 어떻게 해결할까... 스터디원과 함께 고민하다 타이머 정지를 시키는 횟수 제한을 두고, 정지 시에는 백그라운드 상태에 가더라도 화면 전환이 되지 않도록 해보자 라고 이야기가 나왔고, 이를 적용시키기 위해 타이머 정지를 3번 할 수 있도록 기능을 개선함. 그리고 타이머가 초기화되기 전까지는 타이머 정지 횟수가 0이하로 떨어지게 하면 toast가 뜨도록 설정해줌.



~~~swift
 if UserDefaults.standard.integer(forKey: "stop") != 0 {
                UserDefaults.standard.set(false, forKey: "going")
                startButtonBool.toggle()
                self.mainview.startButton.setTitle("시작", for: .normal)
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "stop")-1, forKey: "stop")
                print(UserDefaults.standard.integer(forKey: "stop"))
                mainview.stopCountLabel.text = "멈출 수 있는 기회는 \(UserDefaults.standard.integer(forKey: "stop"))번!"
                
                timer?.invalidate()
                timer = nil
            } else {
                self.mainview.makeToast("멈출 수 있는 기회를 다써버려찌 머얌 :)")
            }
~~~


![Simulator Screen Recording - iPhone 13 Pro - 2022-09-18 at 20 00 53](https://user-images.githubusercontent.com/81552265/190898975-215f0622-905d-4db1-b2c4-f46f792ef60f.gif)




#### 타이머 정지 시에는 Background 상태여도 타이머 초기화 및 화면 전환이 되지 않도록 설정

이제 타이머 정지 시에는 Background에 가더라도 타이머가 초기화되고 화면전환이 되지 않도록 설정해줌. 이것에 대한 판단을 UserDefaults 로 설정해 주었는데, 이 방향이 맞는지에 대한 고민은 필요하다고 생각.



~~~swift
if UserDefaults.standard.bool(forKey: "going") {
            print("sceneDidEnterBackground")
            
            MainViewController().timer?.invalidate()
            MainViewController().timer = nil
            UserDefaults.standard.set(false, forKey: "going")
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)
            let rootViewController = ResetPopupViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()

}
~~~

![Simulator Screen Recording - iPhone 13 Pro - 2022-09-18 at 20 02 11](https://user-images.githubusercontent.com/81552265/190898963-8af831e9-534d-4650-83d8-364bdaa9c986.gif)



#### 위와 관련된 오류에 대해 toast를 사용하여 예외 처리 / 기존 Alert 사용 부분 toast로 전환

UI의 일관성을 주고 싶다고 생각했고, 기존에 사용하던 Alert에 대한 처리를 toast로 변환시켜주었음.

### 22.09.19 (월)

- View가 화면에 쌓이는 문제 해결
- Thema UI 구성
- Thema Color Set 설정 및 구조화
- Setting VC에서 Thema 선택 가능
- 화면전환 시 circulatorProgressView와 ImageView에 대한 오류 발생 -> 미해결

#### View가 화면에 쌓이는 문제 해결

VC에서 Push로 화면을 전환해준 부분들을 presentFullNav 방식으로 전환해주어 stack에 view가 쌓이는 것을 처리해주었음. 

#### Thema UI 구성

<img width="358" alt="스크린샷 2022-09-20 오전 12 34 26-3601673" src="https://user-images.githubusercontent.com/81552265/191059615-70a0dbf8-4820-4789-93ad-dca826ebef9a.png">



구성할 테마에 대해 VC를 구성해주고 TableCell에 표현해주었음.

#### Thema Color Set 설정 및 구조화

~~~swift
import UIKit

enum Thema {
    case SeSACThema
    case PurpleThema
    case PinkThema
    case NightThema
    case BeachThema
    
    var mainColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntGreen
        case .PurpleThema:
            return .huntPurple
        case .PinkThema:
            return .huntPink
        case .NightThema:
            return .huntNight
        case .BeachThema:
            return .huntBeach
        }
        
    }
    
    var lightColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntLightGreen
        case .PurpleThema:
            return .huntLightPurple
        case .PinkThema:
            return .huntLightPink
        case .NightThema:
            return .huntLightNight
        case .BeachThema:
            return .huntLightBeach
            
        }
    }
    
    var progressColor: UIColor {
        switch self {
        case .SeSACThema:
            return .huntYellow
        case .PurpleThema:
            return .huntPurpleWhite
        case .PinkThema:
            return .huntPinkWhite
        case .NightThema:
            return .huntNightPurple
        case .BeachThema:
            return .huntBeachWhite
        }
    }
    
    var calendarChoiceColor: UIColor {
        switch self {
        case .SeSACThema:
            return .customDarkGreen
        case .PurpleThema:
            return .huntPurpleBlue
        case .PinkThema:
            return .huntPinkRed
        case .NightThema:
            return .huntNightPink
        case .BeachThema:
            return .huntLightBeachSky
        }
    }
}

func themaChoice() -> Thema {
    if UserDefaults.standard.integer(forKey: "thema") == 0 {
        return Thema.SeSACThema
    } else if UserDefaults.standard.integer(forKey: "thema") == 1 {
        return Thema.PurpleThema
    } else if UserDefaults.standard.integer(forKey: "thema") == 2 {
        return Thema.PinkThema
    } else if UserDefaults.standard.integer(forKey: "thema") == 3 {
        return Thema.NightThema
    } else {
        return Thema.BeachThema
    }
}

~~~



새 파일을 만들고, enum에 각 테마에 대해 선언해주고 테마당 UIColor Set을 설정해주었음. 이를 UserDefaults를 통해 각각의 테마를 return값으로 표현해주는 방식으로 구현하였음.



또한 각 view에서 color을 지정한 부분에 대해 테마에 대한 색으로 변경해주었음

~~~swift
view.backgroundColor = themaChoice().mainColor

~~~

<img width="300" alt="스크린샷 2022-09-20 오전 12 38 50-3601938" src="https://user-images.githubusercontent.com/81552265/191059502-e2be6e96-c5f4-4a66-a975-e137a68f4b08.png">

<img width="300" alt="스크린샷 2022-09-20 오전 12 39 12" src="https://user-images.githubusercontent.com/81552265/191059519-d720ba9a-5db6-4345-9db6-32b80c2d978e.png">
<img width="300" alt="스크린샷 2022-09-20 오전 12 39 25" src="https://user-images.githubusercontent.com/81552265/191059531-36db39bf-993f-48bf-ac3c-cf3b7c4473c1.png">
<img width="300" alt="스크린샷 2022-09-20 오전 12 40 05" src="https://user-images.githubusercontent.com/81552265/191059538-064b8808-b6df-4128-9bb0-96a89d6259da.png">


#### ThemaSetting VC에서 Thema 선택 가능

~~~swift
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(0, forKey: "thema")
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 1:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(1, forKey: "thema")
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 2:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(2, forKey: "thema")
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 3:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(3, forKey: "thema")
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }
        case 4:
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                UserDefaults.standard.set(4, forKey: "thema")
                let mainViewController = MainViewController()
                transition(mainViewController, transitionStyle: .presentFullNavigation)
            }


        default:
            print("error발생")
        }
    }

~~~

ThemaVC에서 Thema를 고를 수 있게 선언해주었고, 각 셀을 클릭 시 UserDefaults에 값을 저장하고 만약 타이머가 진행되고 있으면 변경할 수 없도록 조건문을 통해 처리해주었음.

#### 화면전환 시 circulatorProgressView와 ImageView에 대한 오류 발생 -> 미해결


<img width="250" alt="스크린샷 2022-09-20 오전 12 44 58-3602302" src="https://user-images.githubusercontent.com/81552265/191059355-c3f223c6-ad32-481c-b342-23047048668b.png">
<img width="250" alt="스크린샷 2022-09-20 오전 12 45 17" src="https://user-images.githubusercontent.com/81552265/191059376-a61fa598-9fff-47c8-b525-e34fde2832f3.png">



화면 전환 시 circulator Progress View 안에 있는 imageView가 안에 있다가 앞으로 나오는 문제가 발생하였다. print로 전부 찍어봐도 순서에 대한 변화는 없는데 자꾸 오류가 발생하여 UI적으로 오류가 없는 것 처럼 배경을 기본 세팅배경색으로 변경하였지만, 근본적인 오류 해결방법이 아닌 것 같아 고민해보고 수정해볼 것이다.



### 22.09.20 (화)

- Circulator progress 위에 imageView가 화면전환 시 화면깨짐 오류 해결
- 기획 수정 및 Realm 설계



#### Circulator progress 위에 imageView가 화면전환 시 화면깨짐 오류 해결

화면 깨짐 오류는 Corner Radius가 처음에만 적용되었다가 이후 화면 전환 시 적용이 되지 않아 발생한 문제였다.

처음 imageView를 그려줄 때 

~~~swift
    let iconImageView: UIImageView = {
    DispatchQueue.main.async {
    	        self.mainview.iconImageView.clipsToBounds = true
        self.mainview.iconImageView.layer.cornerRadius =
        self.mainview.iconImageView.frame.size.width / 2
    }
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "seeds")
        view.backgroundColor = themaChoice().mainColor


        return view
    }()
~~~

이렇게 그려주었다. 이때는 뷰의 생명주기에 대해 생각하지 않고 작성했던 코드였는데, 이렇게 코드를 작성하니 문제가 발생한 거였다.

이같은 문제가 발생한 이유는, DispatchQueue에 보내면 뷰를 그릴 때 한번만 처리하게 되는데, corner radius는 화면이 전환될 때 뷰가 그려진 후 깎아주어야 하기 때문에 화면이 전환될 때마다 실행해줘야한다. 그러면 viewWillAppear에 그려주면 된다고 생각했고, 작성했다.

-> 이때도 오류 발생

ViewWillAppear 부분에 작성해도, DispatchQueue에 작성해야하는 문제가 발생했다. 왜냐하면 View가 아직 나타나기 전이라 위치를 잡지 못하기 때문에 corner radius로 깎을 수가 없는것이였다! 따라서 화면전환될 때마다 뷰를 깎아줘야하고, 이러한 과정은 뷰가 나타난 다음에 해줘야하기 때문에 ViewDidAppear에 작성하면 DispatchQueue에 보내지 않아도 문제없이 실행된다.

~~~swift
    override func viewDidAppear(_ animated: Bool) {

        self.mainview.iconImageView.clipsToBounds = true
        self.mainview.iconImageView.layer.cornerRadius =
        self.mainview.iconImageView.frame.size.width / 2

    }
~~~



#### 기획 수정 및 Realm 설계

~~~swift
class AppleTree: Object {
  //기존의 Realm
    @Persisted var ATDate: String // 필터링한 날짜
    @Persisted var ATTime: Int // 선택한 Time 시간
    
    @Persisted var ATStartTime: Date // 시작시간
    @Persisted var ATFinishTime: Date? // 끝낸시간
    @Persisted var ATSucess: Bool // 성공 여부
    @Persisted var ATTotalCoin: Int // 코인의 총 개수
    @Persisted var ATThema: List<Bool> // 테마 관리


    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(ATDate: String, ATTime: Int) {
        self.init()
        self.ATTime = ATTime
        self.ATDate = ATDate
    }
~~~

코인 기능을 통해 Thema를 사는 기능, 통계에 넣을 자료들을 더욱 풍성하게 하기 위해 Realm을 추가해줄 필요가 생겼고, Realm에 대한 설계를 위처럼 수정하였다.



### 22.09.21 (수)

- Coin UI 구성
- Coin Logic 설계 및 구현

#### Coin UI 구성


<img width="348" alt="스크린샷 2022-09-23 오전 12 26 20" src="https://user-images.githubusercontent.com/81552265/191795720-fa59a746-6347-4b0e-8103-76cd0e3d6a13.png">


위와 같이 오른쪽 상단에 Coin을 표현해 줄 UI를 구성해주었다.

이 Coin으로 테마를 구입하는 형태로 적용할 것. 이때 coin의 개수를 정해주기 위해 Realm에 totalcoin으로 만들어주고, 계속 이전 값을 가져와 대입하거나 더해주는 구조를 만들어주었다. (이때로 돌아가 멈추라고 소리치고싶다... 멈춰!!!!)



#### Coin Logic 설계 및 구현

~~~swift
    func coinCalculator() -> Int {
        switch UserDefaults.standard.integer(forKey: "engagedTime") {
        case 60 * 15:
            return 1
        case 60 * 30 :
            return 3
        case 60 * 60 :
            return 8
        case 60 * 120:
            return 20
        case 60 * 240:
            return 50
        case 60 * 480:
            return 120
        default:
            return 0
        }
    }
~~~



이렇게 지정시간을 완료할때마다 코인을 뿌려주는 형태를 만들어주고, Repository에

~~~swift
    func coinAppend(item: AppleTree, beforeItem: AppleTree) {
        do {
            try localRealm.write {
                item.ATTotalCoin += beforeItem.ATTotalCoin
            }
        } catch {
            print()
        }
    }
    
    func coinState(item: AppleTree, beforeItem: AppleTree) {
        do {
            try localRealm.write {
                item.ATTotalCoin = beforeItem.ATTotalCoin
            }
        } catch {
            print()
        }
    }
~~~

~~~swift
    func coinState() {
        repository.coinState(item: tasks[tasks.count - 1], beforeItem: tasks[tasks.count - 2])
    }
~~~



이런식으로 이전값과 비교하여 더해주는 로직을 구현했다. (제발 멈춰어....!!!)



이렇게 구현하니 이전값과 비교해서 잘 추가가 되었지만, 다음날이 되니 코인이 초기화되는 오류가 발생했고, 다음날의 날짜에 대한 count가 0일 때 Realm을 추가해주고 이전값과 연결해주는 Logic을 구성해줬다.

이때 당시에는 기능적인 문제는 전부 해결.



### 22.09.22 (목)

- Thema 구입 기능
- Thema 구입에 따른 Logic 구현
- Thema 구입 판단 -> Realm에 List<Bool>형태로 구현

#### Thema 구입 기능

~~~swift
@Persisted var ATThema: List<Bool> // 테마 관리

~~~

테마에 대한 구입여부를 어떻게 판단할까 고민하다가, List<Bool>타입으로 저장해 한번에 판단하자 생각하였다.

이 부분을 적용한것은 List형태를 Realm에 저장할 수 있다는 것을 공부한 부분이어서 학습적으로 많이 도움이 되었다 생각한다. 하지만 이 부분은 독립적 테이블을 만들어 구성하는 형태로 구현했어야 한다.. 이걸 왜 다 구현하고 피드백받으면서 깨닫는걸까...



~~~swift
//테마 구입 했을 때 추가
            self.repository.addItem(item: AppleTree(ATDate: DateFormatterHelper.Formatter.dateStr, ATTime: 0, ATState: 6))
            self.tasks = self.repository.fetch()
            
// 이전과 코인 개수 같도록 만들어주고
            self.repository.coinState(item: self.tasks[self.tasks.count - 1], beforeItem: self.tasks[self.tasks.count - 2])
            
// 이전과 테마 같도록 만들어주고
            self.repository.themaState(item: self.tasks[self.tasks.count - 1], beforeItem: self.tasks[self.tasks.count - 2])

// 테마 구입 시 true로 변경
            self.repository.changeThemaBool(item: self.tasks[self.tasks.count - 1], ThemaNum: ThemaNum)
            
// 테마 구입 시 true 변경 값 및 코인 개수 - 2000 업데이트
            self.repository.themaBuy(item: self.tasks[self.tasks.count - 1], Themalist: self.tasks[self.tasks.count - 1].ATThema, Subtract: self.tasks[self.tasks.count - 1].ATTotalCoin - 2000)
            
            UserDefaults.standard.set(ThemaNum, forKey: "thema")

            let mainViewController = MainViewController()
            transition(mainViewController, transitionStyle: .presentFullNavigation)
~~~

이렇게 열심히 로직을 짰다 ^^.... 이제는 전부 수정해야 하는 코드지만, 이때 당시에는 많은 고민과 수정을 거듭한 코드였다. (Repository에 더 많은 로직 코드가 연결되어있는건 안비밀) 

이부분에서 끝난 것도 아니다.



~~~swift
            if UserDefaults.standard.bool(forKey: "going") {
                self.mainview.makeToast("타이머가 가는 동안은 테마를 설정 할 수 없어요!")
            } else {
                //만약 테마를 구입 안했다면
                if tasks[tasks.count - 1].ATThema[indexPath.row] == false {
                    //만약 코인이 2000개 이하라면
                    if tasks[tasks.count - 1].ATTotalCoin < 2000 {
                        self.mainview.makeToast("이 테마를 구입하기 위해서는 2000코인이 필요해요!")
                    } else {
                        themaBuyAlert(ThemaNum: indexPath.row, message: "2000코인으로 구매할까요?💸")
                    }
                } else {
                    UserDefaults.standard.set(4, forKey: "thema")
                    addRecord()
                    coinState()
                    themaState()

                    let mainViewController = MainViewController()
                    transition(mainViewController, transitionStyle: .presentFullNavigation)
                }
            }
~~~

이 로직을 연결하기 위해 또 이것을 판단하는 로직에 대해 짜야했고, 하나의 기능을 구현하기 위해 몇백줄을 적으면서 알고리즘의 중요성과 코드의 구조화를 깨닫는 경험이었다. 이부분을 미리 다 정리하고 구현해야 했어야하는데, 코드를 써내려가면서 생각하다보니 정리도 안되고 지저분한 코드로 써내려가게 되었다. 결국 Coin로직처럼 Thema도 연결하려면 전 데이터와 비교하는 로직을 구성하게 되었고, 이부분도 전부 새로 수정해주어야 하는 코드로 남게되었다.




![Simulator Screen Recording - iPhone 13 Pro Max - 2022-09-23 at 00 52 39](https://user-images.githubusercontent.com/81552265/191795645-35d7c97c-63ee-4afb-8e06-1e491f9909d8.gif)





이제는 못보는 Simulator...

그래도 통계를 들어가기 전 문제를 발견하고, 또 DB에 대해 깊게 공부할 수 있어서 많은 성장을 한 경험이라고 생각한다.

|              |                                            |                                   |
| ------------ | ------------------------------------------ | --------------------------------- |
|              |                                            |                                   |
|              |                                            |                                   |
|              |                                            |                                   |
|              |                                            |                                   |
|              |                                            |                                   |
|              |                                            |                                   |
|              |                                            |                                   |
| 22.10.01(토) | UI 최종 수정 및 앱 출시                    | 드디어 출시!!! grow time!!        |
| 22.10.02(일) | pagination / 추천 코드 입력 창 업데이트    | Reject... 추천 코드는 리젝사유... |
| 22.10.03(월) | 추천코드 기능 제외 재업데이트 및 버그 수정 | 업데이트 1시간만에 바로!!         |

### 22.09.23(금)

- 중간 발표



#### 중간 발표 후기

지금 만들어진 상태는 전부 수정해서 다시 재구현해야하는 상태이지만, (coin 및 thema 관련해서 새로운 테이블을 파는 구조로 재설계해야함.) 우선 중간발표는 지금 코인이 업데이트되고, 지정 시간을 완료할 때마다 잘 적용되어지는 상태이다. ![스크린샷 2022-10-04 오후 1.58.38](README.assets/스크린샷 2022-10-04 오후 1.58.38.png)

이렇게 핵심 기능들을 정리해서 시연영상으로 보여주었고, 다른 사람들의 앱을 구경할 수 있고, 많이 자극받은 시간이었던 것 같다.

### 22.09.24(토)

- Realm 구조 재설계

#### Realm 구조 재설계

Realm의 구조를 한번 바꾸면 지옥이 펼쳐진다는 것을 느낀 하루였다... 기존에 사용되었던 Realm 관련 메서드부터 적용시킨 부분들을 전부 수정해주는 작업이 필요했고, 처음 Realm을 바꾼 후 오류는 87개였다... 까마득했지만 하나하나씩 처리해나가다보니 문제없이 잘 돌아갔다.

특히 이번 램설계를 하면서 추후에 업데이트 할 부분까지 고려하여 미리 만들어두는것이 중요하다고 느꼈고, 어떤 테이블을 분리해야하고, 어떻게 연결하는지에 대해 심도깊은 고민을 한 부분이라 학습적 측면에서도 많은 도움이 된 것 같다.



### 22.09.25(일)

- Font 변경 기능 추가

#### Font 변경 기능 추가

중간 발표 feedback때 폰트에 대한 피드백도 왔었다. 이때 코인으로 테마만 살 수 있게 만들었다보니, font도 구매할 수 있게 만들면 좋겠다 라는 생각을 했고, 램을 재설계를 해봤을 때 폰트 테이블도 함께 추가하자 라고 판단을 내렸다. 이에 Realm 테이블에 Font 테이블도 추가해주었고, Font 설정 UI 및 300코인으로 살 수 있게 변경해주었다.



### 22.09.26(월)

- Charts 라이브러리 사용하여 chart 구현

- chart UI 구성 및 데이터 뿌려주기 완료

  #### Charts 라이브러리 사용하여 chart 구현 및 데이터 뿌려주기 완료

![Simulator Screen Shot - iPhone 13 Pro Max - 2022-10-01 at 03.53.22](README.assets/Simulator Screen Shot - iPhone 13 Pro Max - 2022-10-01 at 03.53.22.png)

위를 구현하면서 느낀 건, chart 라이브러리는 커스텀이 너무 어렵다는 것을 느꼈다. 추후에 라이브러리를 제거하고 원하는 형식으로 custom 할 수 있도록 만들어보고 싶은 부분이다. 그래도 원하는 형태로 데이터도 뿌려주었고, 잘 데이터도 들어가는 것을 확인해 볼 수 있었다.



#### 22.09.27(화)

- 아카이빙 및 testFlight 초대 

- Calendar label 수정

  #### 아카이빙 및 testFlight 초대 

처음으로 testFlight를 사용해서 지인과 같은 SeSAC 팀원분들에게 테스트로 사용할 수 있도록 배포했다. 다른 팀원분들의 피드백도 조금 더 직관적으로 받을 수 있게 되었고, 오류 부분도 확인할 수 있었다. (여기서 화면 쌓임 문제가 발생하고 있었다는 것도 알게 되었음.)

테스트 플라이트를 사용해서 함께 문제점이나 개선점을 보는 부분이 얼마나 중요한 지 느낀 경험이었다.



#### Calendar label 수정

Calendar에 explain Label에서 매일 6시간 이상 공부를 했던 날들에 대한 filter을 거는 것이 어렵다고 생각했고, 새로 어떤 부분을 보여주는 것이 좋을까 구상하다 하루에 집중 성공을 몇 번 했는지 보여주는 것이 좋을 것이라고 생각했다. 

~~~swift
func monthCount(date: Date) -> Int {
        
        let setDate = date
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko")
        
        let components = calendar.dateComponents([.year, .month], from: setDate)
        
        //day를 기입하지 않아서 현재 달의 첫번쨰 날짜가 나오게 된다
        let startOfMonth = calendar.date(from: components)!
        
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth)
        
        
        let item = localRealm.objects(UserTable.self).filter("StartTime >= %@ and StartTime < %@ ", startOfMonth, nextMonth)
        let successMonth = item.filter("Success == true")
        return successMonth.count
    }

cell.explainLabel.text = "이번 달에는 \(repository.monthCount(date: Date()))번 성공하셨어요 👍🏻"

~~~



이렇게 달에 몇번 성공했는지 보여주면 좋을 것이라고 생각했고, 달에 성공 횟수를 출력하도록 만들었다.

### 22.09.28(수)

- UI 업데이트 -> Icon Set 설정

#### UI 업데이트 -> Icon Set 설정


앱 아이콘을 직접 만들어주었다. keynote를 사용해서 직접 만들어 보았는데, 내가 생각한 느낌은 직접 그린 일러스트같은 느낌을 원했지만, 나의 디자인 실력과 손가락으로는 불가능하다는 것을 깨닫고 귀엽게 만들어보았다.  

![1024](https://user-images.githubusercontent.com/81552265/193756756-aa7b1432-9c15-4f2b-930d-69899fed0f50.png)


![appletreeIconGray 001-4863634](https://user-images.githubusercontent.com/81552265/193756794-29ea8fbf-47ec-4be2-873a-a4f720bd56ac.png)



이를 이용하여 제한 시간을 완료하지 못하고 background 상태로 갔을 때 식물이 시드는 이미지를 위로 사용하려고 아이콘을 이용해서 적용시켜주었다.

디자이너의 중요성을 느낀 하루였다. 정말 스스로 디자인을 고민하고 만든다는 것도 쉽지 않다는 것을 절실히 느꼈다.

### 22.09.29(목)

- 화면 쌓임 문제 해결
- 앱 첫 출시 (리jack...)

#### 화면 쌓임 문제 해결

지금까지 presentFullNavigation 방식으로 처리하면 화면이 안쌓이는 줄로만 알고 있었는데, 사실 쌓이고 있다는 것을 피드백에서 듣고 알게되었다. 찾아보니 화면 쌓임 문제를 해결하기 위해선 rootViewController 을 변경해주는 방식으로 해결해야 한다는 것을 알게 되었다.

~~~swift
// rootVC 변경 코드
    func changeRootVC() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        
        let vc = MainViewController()
        UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        let navi = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()

    }
~~~

rootVC를 변경해주고, present로 화면전환하는 부분에 changeRootVC() 를 심어주어서 화면 전환 부분을 해결했다. 애니매이션이 없으니 너무 급격하게 변환되는 것 같아 애니메이션 처리까지 해주었다.



#### 대망의 앱 첫 출시

우선 목요일날 출시 권장일이었기에, 지금까지 완료된 것을 바탕으로 앱을 출시했다. 개인정보 처리방침에 대한 것도 처음 작성해보는 것이였기에 출시 버튼을 누르는데까지만 하더라도 약 3시간 정도가 소요되었다.



-> Reject 당함.. ㅋㅋ...



### 22.09.30(금)

- 통계 UI 깨짐 수정
- 기획 재설계 및 앱 이름 변경
- Reject 사유

#### 통계 UI 깨짐 수정

통계부분이 Double형태로만 출력되다보니 기종에 따라 숫자가 깨지는 것을 알게 되었다. 앱도 리젝된 김에 신경쓰였던 오류들을 수정하고, 앱 이름도 다시 변경하고 주말동안 추가할 부분들을 수정해서 다시 제출하자라고 마음먹었고, 수정해주었다.

####  기획 재설계 및 앱 이름 변경

사과나무라는 앱이름은 무언가 이 앱에 대한 정체성을 알려주기 애매하다는 생각이 들었다. 타 앱들을 보면 앱 이름만 보더라도 어떠한 앱인지 직관적으로 생각이 드는데, 사과나무라는 이름은 집중 타이머 앱과는 연관성이 떨어진다고 생각하였고, 그로우 타임이라는 이름으로 변경하였다.



#### Reject 사유

<img width="250" alt="스크린샷 2022-09-30 오전 11 10 11" src="https://user-images.githubusercontent.com/81552265/193756927-2a0420d8-43ff-4bdf-b6c0-1a3bbbf907b7.png">

리젝의 사유로는 코인 시스템에 대한 질문이었는데, 이 앱에서 코인이 어떻게 벌리고, 어떻게 사용되는지 리뷰어에게 설명해달라는 답변을 받았다. 기능적 오류는 아니였고 다행히 설명만 다시금 해주면 되는 부분이었다.



### 22.10.01(토)

- UI 최종 수정 및 앱 재출시



![IMG_0006](https://user-images.githubusercontent.com/81552265/193756973-678c2fdc-d4af-495e-a084-2813a7e4aa3a.PNG)



![IMG_0017](https://user-images.githubusercontent.com/81552265/193756981-d90fd930-7a72-43b2-be9f-a210848b3a5f.png)



디자이너의 힘을 빌려 앱과 어울리는 이미지를 구상하고 나무가 자라나는 형태로 이미지 에셋을 설정해주었다. 디자이너의 힘을 느낄 수 있었고, 내가 원하는 느낌의 앱을 구성할 수 있게 되었다.

이를 토대로 새로 앱을 구성하였고, 이제 대망의 앱 재출시를 하였다.



### 22.10.02(일)

- 앱 출시🥹

- pagination 기능 구현
- 추천 코드 입력 구성 - reject

#### 앱 출시🥹

대망의 앱 출시가 되었다...! 일요일 아침에 눈을 뜨니 바로 앱이 출시가 되어있는 것을 볼 수 있었다. 드디어 나의 앱이 올라간다고 생각하니 신기하고, 들뜬 하루였지 않나 생각한다.

오히려 앱이 올라가니 더욱 기능을 추가하고 싶어졌고, 바로 개발을 시작했다.



#### pagination 기능 구현

지인 피드백 중, 이 앱을 사용할 때 어떻게 사용하는지 알려주지 않고 처음부터 시간설정 화면부터 실행되는 것은 어색하다라는 피드백을 받았고, pagination을 구현해보자 생각하였다. 이전에 배웠던 것이지만, 다시 pagination을 구현하는 것은 생각보다 헷갈렸지만, 열심히 구글링을 한 덕에 구현을 완료했다.



~~~swift
class PageNationViewController: UIPageViewController {
    
    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = themaChoice().mainColor
        return view
    }()

    //뷰컨트롤러 배열

    lazy var vc1: UIViewController = {
        let vc = FirstViewController()
        vc.view.backgroundColor = .red

        return vc
    }()

    lazy var vc2: UIViewController = {
        let vc = SecondViewController()
        vc.view.backgroundColor = .green

        return vc
    }()

    lazy var vc3: UIViewController = {
        let vc = ThirdViewController()
        vc.view.backgroundColor = .blue

        return vc
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewDidLoad()에서 호출
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        configure()
        setupDelegate()
        

    }
    
    private func configure() {
        view.addSubview(navigationView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)

        navigationView.snp.makeConstraints { make in
            make.width.top.equalToSuperview()
            make.height.equalTo(72)
        }

        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)

        func setupDelegate() {
            pageViewController.dataSource = self
            pageViewController.delegate = self
        }
    }
    
    private func setupDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }

}

extension PageNationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
~~~



#### 추천 코드 입력 구성 - reject

이 앱을 사용하는 지인들에게 코인을 지급하고 싶어 추천 코드 입력 창을 만들었다. 특정 키워드를 입력하면 코인을 제공하도록 구성하였다.



~~~swift
    @objc func finishButtonClickedCountDown() {
        
        coinTasks = repository.fetchCoinTable()
        
        if mainview.codeInputTextField.text == "SeSAC" {
            if UserDefaults.standard.string(forKey: "SeSAC") == "SeSAC" {
                self.mainview.makeToast("이미 사용하신 코드입니다.")
            } else {
                repository.addCoin(item: CoinTable(GetCoin: 3000, SpendCoin: 0, Status: 1000))
                UserDefaults.standard.set("SeSAC", forKey: "SeSAC")
                self.mainview.makeToast("SeSAC 화이팅🌱")
            }
        } else if mainview.codeInputTextField.text == "growtime" {
            if UserDefaults.standard.string(forKey: "growtime") == "growtime" {
                self.mainview.makeToast("이미 사용하신 코드입니다.")
            }
        }
~~~



-> 리젝사유... 멘토님께 물어보니 추천 코드는 무조건 리젝이라고 알려주셨다...



### 22.10.03(월)

- 추천 코드 기능 제외 업데이트 제출

####  추천 코드 기능 제외 업데이트 제출

<img width="250" alt="스크린샷 2022-10-03 오후 11 32 51" src="https://user-images.githubusercontent.com/81552265/193757075-cf95ed45-8e88-42f4-aec8-2a5131534aa6.png">


Reject을 받고 스크린샷도 찍어 보내줬다... 애플...

<img width="250" alt="스크린샷 2022-10-03 오후 11 33 08" src="https://user-images.githubusercontent.com/81552265/193757086-8bbdc1fb-7b33-416a-8253-9912df4e20d1.png">


위 화면을 스크린샷을 첨부하여 보내줌...

추천 코드 기능을 제외하고 다시 심사를 넣었더니, 한시간도 안걸려 바로 업데이트가 되었다. 내 쿠폰 코드창.. 잘가...

그래도 이렇게 리젝이 되면서 점차 다양한 정보들을 얻게 되었다고 생각되어 경험적 측면에서 좋은 경험이지 않았나 생각한다.





