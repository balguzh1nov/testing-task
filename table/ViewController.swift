//
//  ViewController.swift
//  table
//
//  Created by Абай on 06.06.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var model: Model?
    var selectedSemester: Semester?
    

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up collection view
        view.backgroundColor = .white
        parseJSON()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
        
        
        
        // Set up navigation bar
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        navigationBar.backgroundColor = .white
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationBar)
        
        // Set up navigation bar constraints
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Create navigation item
        let navigationItem = UINavigationItem()
        
        // Set up back button
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        // Set up title
        navigationItem.title = "Индивидуальный учебный план"
        
        // Set up right bar button item with download system image
        let downloadImage = UIImage(systemName: "arrow.down.circle")
        let downloadButton = UIBarButtonItem(image: downloadImage, style: .plain, target: self, action: #selector(downloadButtonTapped))
        navigationItem.rightBarButtonItem = downloadButton

        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Embed the view controller in a navigation controller
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.isHidden = true
        
        if let academicYear = model?.academicYear {
            // Set the titleLabel text by concatenating strings
            titleLabel.text = "Индивидуальный учебный план " + academicYear
        }
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0 // Allow multiple lines

        // Activate constraints for titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        
        // Set up constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        // Set up constraints
        tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.semesters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        // Customize the appearance of the cell
        let titleLabel = UILabel()
        if let semester = model?.semesters[indexPath.item] {
            titleLabel.text = "Semester \(semester.number)"
        }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(titleLabel)
        
        // Set up constraints for the title label
        titleLabel.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust cell size according to the content (semester number)
        if let semester = model?.semesters[indexPath.item] {
            let semesterNumber = semester.number
            let titleLabel = UILabel()
            titleLabel.text = "Semester \(semesterNumber)"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            
            // Calculate the size needed for the title label based on the content
            let titleSize = titleLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 50))
            
            // Add extra padding to the calculated width
            let width = titleSize.width + 50
            
            return CGSize(width: width, height: 50)
        }
        
        return CGSize(width: 0, height: 50) // Default size if data is unavailable
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let semester = model?.semesters[indexPath.item] {
            selectedSemester = semester
            tableView.reloadData()
            print("Selected section: Semester \(semester.number)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedSemester = selectedSemester else {
            return 0
        }
        return selectedSemester.disciplines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell,
            let discipline = selectedSemester?.disciplines[indexPath.row] else {
                return UITableViewCell()
        }
        
        // Set up discipline name label
        cell.disciplineNameLabel.text = discipline.disciplineName.nameEn
        
        // Clear previous subviews
        cell.lessonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add lesson labels
        for lesson in discipline.lesson {
            let lessonTypeLabel = UILabel()
            lessonTypeLabel.font = UIFont.systemFont(ofSize: 12)
            lessonTypeLabel.textColor = .black
            
            switch lesson.lessonTypeID {
            case "1":
                lessonTypeLabel.text = "Lecture"
            case "2":
                lessonTypeLabel.text = "Seminar"
            case "3":
                lessonTypeLabel.text = "Labs"
            default:
                lessonTypeLabel.text = ""
            }
            
            let hoursValueLabel = UILabel()
            hoursValueLabel.font = UIFont.systemFont(ofSize: 12)
            hoursValueLabel.textColor = .black
            hoursValueLabel.text = "\(lesson.realHours)/\(lesson.hours)"
            
            let lessonStackView = UIStackView(arrangedSubviews: [lessonTypeLabel, hoursValueLabel])
            lessonStackView.axis = .vertical
            lessonStackView.spacing = 4
            cell.lessonStackView.addArrangedSubview(lessonStackView)
        }
        
        return cell
    }
        

    // Add this function to your ViewController
    @objc private func downloadButtonTapped() {
        guard let documentURL = model?.documentURL else {
            // Document URL is not available, handle the error or show an alert
            return
        }

        // Perform download logic using the documentURL
        let session = URLSession.shared
        guard let url = URL(string: documentURL) else {
            // Invalid document URL, handle the error or show an alert
            return
        }

        let task = session.downloadTask(with: url) { (localURL, response, error) in
            if let error = error {
                // Download error occurred, handle the error or show an alert
                print("Download error: \(error)")
            } else if let localURL = localURL {
                // Download completed successfully, localURL points to the temporary location of the downloaded file

                // Move the downloaded file to a permanent location if needed
                // For example, you can move it to the user's documents directory

                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                let destinationURL = documentsDirectory?.appendingPathComponent("DownloadedFile.pdf")

                do {
                    try FileManager.default.moveItem(at: localURL, to: destinationURL!)

                    // File moved successfully, handle the success or show an alert
                    print("Download completed. File saved at: \(destinationURL!)")
                } catch {
                    // Failed to move the file, handle the error or show an alert
                    print("Error moving file: \(error)")
                }
            }
        }

        task.resume()
    }

    
    private func parseJSON() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            model = try JSONDecoder().decode(Model.self, from: jsonData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}
