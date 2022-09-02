//
//  DatabaseHelper.swift
//  MemberDicoding
//
//  Created by Gilang Ramadhan on 24/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import CoreData
import UIKit

class MemberProvider {

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "MemberDicoding")

    container.loadPersistentStores { _, error in
      guard error == nil else {
        fatalError("Unresolved error \(error!)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = false
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.undoManager = nil

    return container
  }()

  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.undoManager = nil

    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }

  func getAllMember(completion: @escaping(_ members: [MemberModel]) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Member")
      do {
        let results = try taskContext.fetch(fetchRequest)
        var members: [MemberModel] = []
        for result in results {
          let member = MemberModel(
            id: result.value(forKeyPath: "id") as? Int32,
            name: result.value(forKeyPath: "name") as? String,
            email: result.value(forKeyPath: "email") as? String,
            profession: result.value(forKeyPath: "profession") as? String,
            about: result.value(forKeyPath: "about") as? String,
            image: result.value(forKeyPath: "image") as? Data
          )

          members.append(member)
        }
        completion(members)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }

  func getMember(_ id: Int, completion: @escaping(_ members: MemberModel) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Member")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      do {
        if let result = try taskContext.fetch(fetchRequest).first {
          let member = MemberModel(
            id: result.value(forKeyPath: "id") as? Int32,
            name: result.value(forKeyPath: "name") as? String,
            email: result.value(forKeyPath: "email") as? String,
            profession: result.value(forKeyPath: "profession") as? String,
            about: result.value(forKeyPath: "about") as? String,
            image: result.value(forKeyPath: "image") as? Data
          )

          completion(member)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }

  func createMember(
    _ name: String,
    _ email: String,
    _ profession: String,
    _ about: String,
    _ image: Data,
    completion: @escaping() -> Void
  ) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      if let entity = NSEntityDescription.entity(forEntityName: "Member", in: taskContext) {
        let member = NSManagedObject(entity: entity, insertInto: taskContext)
        self.getMaxId { id in
          member.setValue(id+1, forKeyPath: "id")
          member.setValue(name, forKeyPath: "name")
          member.setValue(email, forKeyPath: "email")
          member.setValue(profession, forKeyPath: "profession")
          member.setValue(about, forKeyPath: "about")
          member.setValue(image, forKeyPath: "image")

          do {
            try taskContext.save()
            completion()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        }
      }
    }
  }

  func updateMember(
    _ id: Int,
    _ name: String,
    _ email: String,
    _ profession: String,
    _ about: String,
    _ image: Data,
    completion: @escaping() -> Void
  ) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Member")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      if let result = try? taskContext.fetch(fetchRequest), let member = result.first as? Member {
        member.setValue(name, forKeyPath: "name")
        member.setValue(email, forKeyPath: "email")
        member.setValue(profession, forKeyPath: "profession")
        member.setValue(about, forKeyPath: "about")
        member.setValue(image, forKeyPath: "image")
        do {
          try taskContext.save()
          completion()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    }
  }

  func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Member")
      let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
      fetchRequest.sortDescriptors = [sortDescriptor]
      fetchRequest.fetchLimit = 1
      do {
        let lastMember = try taskContext.fetch(fetchRequest)
        if let member = lastMember.first, let position = member.value(forKeyPath: "id") as? Int {
          completion(position)
        } else {
          completion(0)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }

  func deleteAllMember(completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }

  func deleteMember(_ id: Int, completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }

  func addMemberDummy(completion: @escaping() -> Void) {
    for member in memberDummies {
      if let name = member.name, let email = member.email, let profession = member.profession, let about = member.about, let image = member.image {
        self.createMember(name, email, profession, about, image) {
          completion()
        }
      }
    }
  }
}
