//
//  MemberDummy.swift
//  MemberDicoding
//
//  Created by Gilang Ramadhan on 26/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

var memberDummies: [MemberModel] = [
  MemberModel(id: nil, name: "Ahmad Arif Faizin", email: "arif@dicoding.com", profession: "Academy Content Writer at Dicoding Indonesia", about: "Bergabung sejak Juli 2019. Membantu kembangkan konten Academy, khususnya Android. Misinya, bermanfaat untuk developer dengan membuat konten yang mudah dipahami. Pernah diundang hadir Google I/O 2018.", image: imageToData("Ahmad Arif Faizin")),
  
  MemberModel(id: nil, name: "Ahmad Imaduddin", email: "arif@dicoding.com", profession: "Head Of Academy at Dicoding Indonesia", about: "Bergabung sejak 2016 sebagai Head of Academy. Bertanggung jawab pada pengembangan seluruh konten Academy di Dicoding. Mottonya, \"Tulislah kode setiap hari walau hanya 1 baris.\"", image: imageToData("Ahmad Imaduddin")),
  
  MemberModel(id: nil, name: "Buchori Rafsanjani", email: "buchori@dicoding.com", profession: "Academy Content Writer at Dicoding Indonesia", about: "Bergabung sejak September 2019 sebagai Academy Content Writer. Sebelumnya sempat jadi staf magang dan External Reviewer Dicoding. Motto Buchori, \"Jadikan hari esok lebih baik dari hari-hari yang telah berlalu.\"", image: imageToData("Buchori Rafsanjani")),
  
  MemberModel(id: nil, name: "Dimas Maulana Dwi Saputra", email: "dimas@dicoding.com", profession: "Academy Content Writer at Dicoding Indonesia", about: "Mobile dan Web Enthusiast. Mengembangkan konten Academy dengan fokus pada platform web. Menjadi Reviewer pada beberapa kelas Expert yang ada. Mottonya \"Tech is part of life, then get familiar with it.\"", image: imageToData("Dimas Maulana Dwi Saputra")),
  
  MemberModel(id: nil, name: "Gilang Ramadhan", email: "gilang@dicoding.com", profession: "Academy Content Writer at Dicoding Indonesia", about: "Bergabung sejak 2018 sebagai Academy Content Writer. Bertanggung jawab pada pengembangan konten iOS dan Android di Dicoding Academy. Misinya, menyebarkan ilmu yang bermanfaat kepada siapa saja. Share Your Knowledge!", image: imageToData("Gilang Ramadhan")),
  
  MemberModel(id: nil, name: "Muhammad Gheddi", email: "gheddi@dicoding.com", profession: "Academy Content Writer at Dicoding Indonesia", about: "Machine Learning & Data Science enthusiast. Pernah menjadi leader Google Developer Student Club di Universitas Sriwijaya. Aktif mendalami ML setelah mengikuti Google Developers Machine Learning Bootcamp di tahun 2018.", image: imageToData("Muhammad Gheddi")),
  
  MemberModel(id: nil, name: "Widyarso Joko Purnomo", email: "widy@dicoding.com", profession: "Academy Content Writer at Dicoding Indonesia", about: "Bergabung sejak Desember 2018. Menggabungkan passion tentang edukasi dan coding dengan menulis konten academy di Dicoding.", image: imageToData("Widyarso Joko Purnomo"))
  
]

func imageToData(_ title: String) -> Data? {
  guard let img = UIImage(named: title) else { return nil }
  return img.jpegData(compressionQuality: 1)
}
