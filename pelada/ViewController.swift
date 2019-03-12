//
//  ViewController.swift
//  pelada
//
//  Created by Usuário Convidado on 27/02/2019.
//  Copyright © 2019 Usuário Convidado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var quantidadeTextField: UITextField!
    @IBOutlet weak var horarioTextField: UITextField!
    @IBOutlet weak var salvarButton: UIBarButtonItem!
    
    var pelada: Pelada?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nomeTextField.delegate = self
        quantidadeTextField.delegate = self
        horarioTextField.delegate = self
        
        // bind de itens de tela com valores
        if let pelada = pelada {
            navigationItem.title = pelada.nome
            nomeTextField.text = pelada.nome
            
            navigationItem.title = pelada.quantidade
            quantidadeTextField.text = pelada.quantidade
            
            navigationItem.title = pelada.horario
            horarioTextField.text = pelada.horario
        }
        
        atualizarBotaoSalvar()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        salvarButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        atualizarBotaoSalvar()
        navigationItem.title = textField.text
    }
//    função de chamada para click de botão "cacelar" em bar action
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        let estaAdicionandoPelada = presentingViewController is UINavigationController
        if estaAdicionandoPelada{
            dismiss(animated: true, completion: nil)
        } else if let possuiNavigationController = navigationController {
            possuiNavigationController.popViewController(animated: true)
        } else {
            fatalError("PeladaViewController not is inside navigation controller.")
        }
    }
    
//    habilitar botao de "salvar" quando for digitado algo em nome
    private func atualizarBotaoSalvar() {
        let texto = nomeTextField.text ?? ""
        salvarButton.isEnabled = !texto.isEmpty
    }
    
    //prepara envio de dados de opelada para salvar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let botao = sender as? UIBarButtonItem, botao == salvarButton else {
            fatalError("Error button save.")
        }
        
        let nome = nomeTextField.text ?? ""
        let quantidade = quantidadeTextField.text ?? ""
        let horario = horarioTextField.text ?? ""
        
        pelada = Pelada(nome: nome, quantidade: quantidade, horario: horario)
    }

}

