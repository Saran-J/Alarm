import UIKit
import Charts

protocol InvestmentDisplayLogic: class {
}

class InvestmentViewController: TabViewController, InvestmentDisplayLogic {
    var interactor: InvestmentBusinessLogic?
    var router: (NSObjectProtocol & InvestmentRoutingLogic & InvestmentDataPassing)?
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var savingView: InvestmentView!
    @IBOutlet weak var stockView: InvestmentView!
    @IBOutlet weak var fundView: InvestmentView!
    
    let chartData: [ChartData] = [
        ChartData(
            value: 0.5,
            title: "เงินฝาก",
            color: UIColor.colorWithRGBA(94, 139, 142)),
        ChartData(
            value: 0.25,
            title: "กองทุนรวม",
            color: UIColor.colorWithRGBA(184, 148, 54)),
        ChartData(
            value: 0.25,
            title: "หลักทรัพย์",
            color: UIColor.colorWithRGBA(33, 133, 206))
    ]
    
    let savingData = InvestmentData(
        type: .saving,
        value: "10,000,000.00",
        percentageChange: ""
    )
    
    let stockData = InvestmentData(
        type: .stock,
        value: "23,540.32",
        percentageChange: "2,023.12 (9.12%)"
    )
    
    let fundData = InvestmentData(
        type: .fund,
        value: "500,000.00",
        percentageChange: "-1,000.00 (0.52%)"
    )
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    static func initFromStoryboard() -> InvestmentViewController {
        let viewController = UIStoryboard(
            name: "Investment",
            bundle: nil)
            .instantiateInitialViewController() as! InvestmentViewController
        return viewController
    }
    
    func setupHeader() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.headerView.frame
        rectShape.position = self.headerView.center
        rectShape.path = UIBezierPath(
            roundedRect: self.headerView.bounds,
            byRoundingCorners: [.bottomLeft],
            cornerRadii: CGSize(width: 25, height: 25)
        ).cgPath
        self.headerView.layer.mask = rectShape
    }
    
    func generatePieChart() {
        let dataEntries: [ChartDataEntry] =
            chartData.enumerated().map { index, data -> ChartDataEntry in
                ChartDataEntry(x: Double(index), y: data.value)
            }
        let dataColor: [UIColor] = chartData.map { data -> UIColor in
            data.color
        }
        
        let pieChartDataSet = PieChartDataSet(
            entries: dataEntries,
            label: nil)
        pieChartDataSet.colors = dataColor
        pieChartDataSet.valueLinePart1Length = 0.4
        pieChartDataSet.valueLineColor = .clear
        pieChartDataSet.valueLinePart2Length = 0.5
        pieChartDataSet.yValuePosition = .outsideSlice
        pieChartDataSet.valueFont = UIFont.ktbFont(
            size: 16,
            style: .regular)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .percent
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        chartView.data = pieChartData
        chartView.legend.enabled = false
        chartView.transparentCircleColor = .clear
        chartView.holeColor = .clear
        chartView.rotationAngle = 45
    }
    
    func setupInvestmentView() {
        savingView.setupView(data: savingData)
        fundView.setupView(data: fundData)
        stockView.setupView(data: stockData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = InvestmentInteractor()
        let presenter = InvestmentPresenter()
        let router = InvestmentRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.setupHeader()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generatePieChart()
        setupInvestmentView()
    }
}
