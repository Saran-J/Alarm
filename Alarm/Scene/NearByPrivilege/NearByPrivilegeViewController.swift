import UIKit
import RxSwift

class NearByPrivilegeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    var viewModel: NearByPrivilegeViewModelProtocol = NearByPrivilegeViewModel()
    var privilegeData: [NearByPrivilegeResponse] = []
    var lastCellSelected: PrivilegeTypeCell?
    
    
    static func initFromStoryboard() -> NearByPrivilegeViewController {
        return UIStoryboard(
            name: "NearByPrivilege",
            bundle: nil
        ).instantiateInitialViewController() as! NearByPrivilegeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        bind()
        viewModel.startLocation()
        viewModel.getNearByPrivilege()
    }
    
    func setupTableView() {
        tableView.register(
            UINib(
                nibName: "NearByCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "nearByCell"
        )
    }
    
    func setupCollectionView() {
        collectionView.register(
            UINib(
                nibName: "PrivilegeTypeCell",
                bundle: nil),
            forCellWithReuseIdentifier: "privilegeTypeCell"
        )
        
        collectionView.register(
            UINib(
                nibName: "BlankCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "blankCell")
    }
    
    func bind() {
        disposeBag = DisposeBag()
        disposeBag.insert(
            backButton.rx.tap.bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            },
            viewModel.output.privilegeResult
                .drive(
                    onNext: { [weak self] response in
                        self?.privilegeData = response
                        self?.tableView.reloadData()
                    }
                ),
            viewModel.output.onError
                .drive(
                    onNext: { [weak self] error in
                        self?.displayMessage(
                            title: "",
                            message: error.description
                        )
                    }
                )
        )
    }
    
    private func isBlankCell(indexPath: IndexPath, data: [Any]) -> Bool {
        if
            indexPath.row == 0 ||
            indexPath.row == data.count + 1 {
            return true
        }
        return false
    }
}

extension NearByPrivilegeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privilegeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "nearByCell") as? NearByCell
        else {
            return UITableViewCell()
        }
        cell.setupCellData(data: privilegeData[indexPath.row])
        return cell
    }
}

extension NearByPrivilegeViewController: UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.collectionHeader.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isBlankCell(indexPath: indexPath, data: viewModel.output.collectionHeader) {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "blankCell",
                for: indexPath
            )
        }
        
        guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "privilegeTypeCell",
            for: indexPath) as? PrivilegeTypeCell else {
            return UICollectionViewCell()
        }
        
        let category = viewModel.output.collectionHeader[indexPath.row - 1]
        cell.setupCell(
            title: category.getName(),
            pos: category.getCellPosition()
        )
        if lastCellSelected == nil {
            lastCellSelected = cell
            lastCellSelected?.isActive = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isBlankCell(indexPath: indexPath, data: viewModel.output.collectionHeader) {
            return CGSize(width: 16, height: 48)
        }
        let cell = collectionView.cellForItem(at: indexPath) as? PrivilegeTypeCell
        let width = cell?.titleLabel.intrinsicContentSize.width ?? 0 + 28
        return CGSize(width: width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isBlankCell(indexPath: indexPath, data: viewModel.output.collectionHeader) {
            return
        }
        selectCell(indexPath: indexPath)
    }
    
    func selectCell(indexPath: IndexPath) {
        lastCellSelected?.isActive = false
        let cell = collectionView.cellForItem(at: indexPath) as? PrivilegeTypeCell
        cell?.isActive = true
        lastCellSelected = cell
        
        let category = viewModel.output.collectionHeader[indexPath.row - 1]
        viewModel.selectCategory(category)
    }
}
