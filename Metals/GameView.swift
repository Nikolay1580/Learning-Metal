//
//  GameView.swift
//  Metals
//
//  Created by Nikolay Tsonev on 30/09/2023.
//

import MetalKit

class GameView : MTKView {
        
    var commandQueue: MTLCommandQueue!
    var renderPipeLineState: MTLRenderPipelineState!
    
    // initializer
    required init(coder: NSCoder) {
        // inherirt from parent class
        super.init(coder: coder)
        
        // abtract var that is the M1 GPU
        self.device = MTLCreateSystemDefaultDevice()
        
        // color we use to clear the image
        self.clearColor = MTLClearColor(red: 0.43, green: 0.73, blue: 0.35,  alpha: 1)
        
        self.colorPixelFormat = .bgra8Unorm
        
        self.commandQueue = device?.makeCommandQueue()
        
        createRenderPipelineState()
    }
    
    // render pipeline state
    // most important part of rendering and contains a descriptor
    func createRenderPipelineState() {
        
        let library = device?.makeDefaultLibrary()
        let vertexFunc = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunc = library?.makeFunction(name: "basic_fragment_shader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunc
        renderPipelineDescriptor.fragmentFunction = fragmentFunc
        
        do {
            renderPipeLineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        // before doing further operations checks if these vars are valid
        guard let drawwable = self.currentDrawable,
              let RenderPassDescriptor = self.currentRenderPassDescriptor
        else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: RenderPassDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(renderPipeLineState)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawwable)
        commandBuffer?.commit()
        
    }
    
    
}
