//
//  AddressViewController.swift
//  Address ticket
//
//  Created by Pedro Léda on 21/07/21.
//

import UIKit

class AddressViewController: UIViewController {
    
    // MARK: Properties
    private var viewModel: AdressViewModel = AdressViewModel()
    var ticket: AddressModel?
    
    // MARK: Outlets
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldCEP: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldAddressNumber: UITextField!
    @IBOutlet weak var textFieldComplement: UITextField!
    @IBOutlet weak var textFieldNeighborhood: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var ButtonTag: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: Initialization
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddressViewController.backgroundTap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddressViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddressViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Actions
    @IBAction func buttonGenerateTag(_ sender: Any) {
        if validateContents() {
            ticket = viewModel.createTicket(name: textFieldName.text!,
                                            cep: textFieldCEP.text!,
                                            address: textFieldAddress.text!,
                                            number: textFieldAddressNumber.text!,
                                            complement: textFieldComplement.text!,
                                            neighborhood: textFieldNeighborhood.text!,
                                            city: textFieldCity.text!,
                                            state: textFieldState.text!)
            let cepValidate = self.viewModel.validateCep(input: ticket?.cep)
            if (cepValidate == false) {
                alertCep()
            }
            navigateForPrintView()
        }
    }
    
    // MARK: Methods
    func navigateForPrintView(){
        let printTicketView: UIViewController
        printTicketView = PrintTicketViewController(ticket: ticket!)
        navigationController?.pushViewController(printTicketView, animated: true)
    }
    
    func validateContents() -> Bool{ 
        if !self.IsEmpty(textFiel: textFieldName){
            alertToFill(fill: "Nome do Destinatario")
        } else if !self.IsEmpty(textFiel: textFieldCEP){
            alertToFill(fill: "CEP")
        }else if !self.IsEmpty(textFiel: textFieldAddress){
            alertToFill(fill: "Endereço")
        }else if !self.IsEmpty(textFiel: textFieldAddressNumber){
            alertToFill(fill: "Numero")
        }else if !self.IsEmpty(textFiel: textFieldCity){
            alertToFill(fill: "Cidade")
        }else if !self.IsEmpty(textFiel: textFieldState){
            alertToFill(fill: "Estado")
        }else {
            return true
        }
        return false
    }
    
    func IsEmpty(textFiel: UITextField) -> Bool {
        if let text = textFiel.text, text.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    private func setupUI() {
        setupButton()
        setUpNavBar()
    }
    
    private func setupButton() {
        ButtonTag.layer.cornerRadius = 6
        ButtonTag.clipsToBounds = true
    }
    func setUpNavBar(){
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 49.0/255.0, green: 99.0/255.0, blue: 126.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        self.navigationItem.title = "Endereço"
    }
    
    func alertToFill(fill: String){
        let alert = UIAlertController(title: "Preencha todos os Campos", message: "Parece que o campo \(fill) não foi preenchido", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(buttonOk)
        present(alert, animated: true, completion: nil)
    }
    
    func alertCep(){
        let alert = UIAlertController(title: "OPS.. Ouve um erro", message: "Preencha corretamente o campo CEP", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(buttonOk)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            // caso o tamanho do teclado não esteja disponivel
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
