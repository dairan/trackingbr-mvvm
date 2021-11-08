//
//  CoreDataGerenciador.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import CoreData
import Foundation

class GerenciadorCoreData {
  // MARK: Lifecycle

  init() {}

  // MARK: Internal

//  static let shared = GerenciadorCoreData()

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentCloudKitContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentCloudKitContainer(name: "EncomandasList")
    container.loadPersistentStores(completionHandler: { storeDescription, error in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
//        container.viewContext.mergePolicy = NSMergePolicyType.mergeByPropertyObjectTrumpMergePolicyType
        container.viewContext.mergePolicy = NSMergePolicyType.mergeByPropertyStoreTrumpMergePolicyType
    })
    return container
  }()

  lazy var contexto: NSManagedObjectContext = {
    persistentContainer.viewContext
  }()

  lazy var fetchResultController: NSFetchedResultsController<Encomenda> = {
    let fetchRequest: NSFetchRequest<Encomenda> = Encomenda.fetchRequest()

    let ordenador = NSSortDescriptor(key: #keyPath(Encomenda.adicionadoEm), ascending: false)
    fetchRequest.sortDescriptors = [ordenador]

    let nsfrc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                           managedObjectContext: contexto,
                                           sectionNameKeyPath: nil,
                                           cacheName: "testeCache")

    return nsfrc

  }()

  // MARK: - Core Data Saving support

  func salvarContexto() {
    if contexto.hasChanges {
      do {
        try contexto.save()
        contexto.reset()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  func adicionar(_ encomenda: EncomendaParaAdicionarDTO) {
    let encomendaCD = Encomenda(context: contexto)
    encomendaCD.codigo = encomenda.codigo
    encomendaCD.descricao = encomenda.descricao
    encomendaCD.adicionadoEm = encomenda.data

    salvarContexto()
  }

  func apagar(encomenda: Encomenda) {
    contexto.delete(encomenda)

    salvarContexto()
  }
}
