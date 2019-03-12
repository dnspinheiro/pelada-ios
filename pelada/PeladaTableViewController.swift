//
//  PeladaTableViewController.swift
//  pelada
//
//  Created by Usuário Convidado on 27/02/2019.
//  Copyright © 2019 Usuário Convidado. All rights reserved.
//

import Foundation
import UIKit

class PeladaTableViewController: UITableViewController {
    
    var peladas = [Pelada]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.title = "Apagar"
        
        if let peladasSalvas = carregarPeladas() {
            peladas += peladasSalvas
        } else {
            loadMockup()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peladas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identificador = "PeladaTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identificador, for: indexPath) as? PeladaTableViewCell else {
            fatalError("The task declareted not is typw PeladaTableViewCell")
        }
        
        let pelada = peladas[indexPath.row]
        
        cell.nomeLabel.text = pelada.nome
        cell.quantidadeLabel.text = pelada.quantidade
        cell.horarioLabel.text = pelada.horario
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            peladas.remove(at: indexPath.row)
            salvarPeladas()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func loadMockup() {
        
        guard let pelada1 = Pelada(nome: "Pelada1", quantidade: "Quant. 14", horario: "sab as 18hs") else {
            fatalError("Error mokup")
        }
        
        peladas += [pelada1]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "AddItemSoS":
            print("Additing a new racha.")
        case "MostrarDetalhesSegue":
            guard let detalhesDaPeladaViewController = segue.destination as? ViewController else {
                fatalError("Target unknown: \(segue.destination)")
            }
            guard let celulaPeladaSelecionada = sender as? PeladaTableViewCell else {
                fatalError("sender unknown: \(sender ?? "")")
            }
            guard let indexPath = tableView.indexPath(for: celulaPeladaSelecionada) else {
                fatalError("The task don't will show in table.")
            }
            
            let peladaSelecionada = peladas[indexPath.row]
            detalhesDaPeladaViewController.pelada = peladaSelecionada
        default:
            fatalError("Identificador do segue desconhecido: \(segue.identifier ?? "")")
        }
    }
    
    private func carregarPeladas() -> [Pelada]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Pelada.caminhoURL.path) as? [Pelada]
    }
    
    @IBAction func voltarPeladas(sender: UIStoryboardSegue) {
        if let viewControllerInicial = sender.source as? ViewController, let pelada = viewControllerInicial.pelada {
            if let indexPathSelecionado = tableView.indexPathForSelectedRow {
                peladas[indexPathSelecionado.row] = pelada
                tableView.reloadRows(at: [indexPathSelecionado], with: .none)
            } else {
                let novoIndexPath = IndexPath(row: peladas.count, section: 0)
                
                peladas.append(pelada)
                tableView.insertRows(at: [novoIndexPath], with: .automatic)
            }
            
            salvarPeladas()
        }
    }
    
    private func salvarPeladas() {
        let salvo = NSKeyedArchiver.archiveRootObject(peladas, toFile: Pelada.caminhoURL.path)
    }
    
}
