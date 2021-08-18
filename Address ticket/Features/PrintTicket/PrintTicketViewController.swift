//
//  PrintTicketViewController.swift
//  Address ticket
//
//  Created by Pedro Léda on 01/08/21.
//

import UIKit

class PrintTicketViewController: UIViewController {

    // MARK: Properties
    private var ticket: AddressModel!
    
    // MARK: Outlets
    
    @IBOutlet weak var labelFullAdress: UILabel!
    @IBOutlet weak var buttonPrint: UIButton!
    // MARK: Initialization
    
    init(ticket: AddressModel) {
        self.ticket = ticket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        var fullAddress: String
//        guard let address = address else { return }
        fullAddress = """
            Nome: \(self.ticket.name)
            Endereço: \(self.ticket.address) Nº: \(self.ticket.number) \(self.ticket.complement)
            Bairro: \(self.ticket.neighborhood)
            CEP: \(self.ticket.cep)
            Cidade: \(self.ticket.city)
            Estado: \(self.ticket.state)
            """
        labelFullAdress.text = fullAddress
    }
    
    // MARK: Actions
    @IBAction func ButtonPrintTicket(_ sender: Any) {
        let alert = UIAlertController(title: "Etiqueta gerada e enviada para impressora", message: nil , preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    // MARK: Methods
    
    func goBack(){
//        let adressView: UIViewController
//        adressView = AddressViewController()
        navigationController?.popViewController(animated: true)
    }
    private func setupUI() {
        setupButton()
        setUpNavBar()
    }
    private func setupButton() {
        buttonPrint.layer.cornerRadius = 6
        buttonPrint.clipsToBounds = true
    }
    func setUpNavBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 49.0/255.0, green: 99.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        self.navigationController?.view.tintColor = UIColor.orange
        self.navigationItem.title = "Seu Ticket"
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
