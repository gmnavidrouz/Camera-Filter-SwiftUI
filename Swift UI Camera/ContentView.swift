//
//  ContentView.swift
//  Swift UI Camera
//
//  Created by Navid Rouzroch on 3/16/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State var selectedImage: UIImage?
    @State var displayPickerView = false
    
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack{
                if let selectedImage = self.selectedImage{
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                    
                } else{
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                }
                HStack{
                    Button(action: {
                        self.sourceType = .photoLibrary
                        self.displayPickerView = true
                    }){
                        Image(systemName: "folder")
                            .font(.title)
                    } .padding()
                    
                    Button(action: {
                        self.sourceType = .camera
                        self.displayPickerView = true
                    }){
                        Image(systemName: "camera")
                            .font(.title)
                    }
                    .padding()
                }
                HStack{
                    Button("Sepia"){
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.sepiaTone()
                            currentFilter.inputImage = beginImage
                            currentFilter.intensity = 1
                            
                            guard let outputImage = currentFilter.outputImage else { return }
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    
                    Button("Disc Blur"){
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.discBlur()
                            currentFilter.inputImage = beginImage
                            
                            guard let outputImage = currentFilter.outputImage else { return }
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    
                    Button("Invert Colors"){
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.colorInvert()
                            currentFilter.inputImage = beginImage
                            
                            guard let outputImage = currentFilter.outputImage else { return }
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    
                    Button("Noir"){
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.photoEffectNoir()
                            currentFilter.inputImage = beginImage
                            
                            guard let outputImage = currentFilter.outputImage else { return }
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    
                    Button("Chrome"){
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.photoEffectChrome()
                            currentFilter.inputImage = beginImage
                            
                            guard let outputImage = currentFilter.outputImage else { return }
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    
                    Button("XRAY"){
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.xRay()
                            currentFilter.inputImage = beginImage
                            
                            guard let outputImage = currentFilter.outputImage else { return }
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    
                }.sheet(isPresented: self.$displayPickerView) {
                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
