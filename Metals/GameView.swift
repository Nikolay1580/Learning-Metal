//
//  GameView.swift
//  Metals
//
//  Created by Nikolay Tsonev on 30/09/2023.
//

import MetalKit

class GameView : MTKView {
    
    // this is like the previosuly user basic Vertex array, but now has th position of the vertex alongside a color
    // color is of 4 floats. 3 for RGB and the 4th for opacity / alpha
    struct Vertex {
        var position: SIMD3<Float>
        var color: SIMD4<Float>
    }
        
    var commandQueue: MTLCommandQueue!
    var renderPipeLineState: MTLRenderPipelineState!
    
    // creating a 3d triangle vertex array to be displayed on screen
    // screen is a unit circle with an x,y,z
    // -1,0,0 for example is the bottom centre of the screen
    // explanation makes it optional
    var vertices: [Vertex]!
    
    // vertex buffer
    var vertexBuffer: MTLBuffer!
    
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
        
        // initing the render pipline
        createRenderPipelineState()
        
        // initing the vertices array
        createVertices()

        // initing the vertex buffer
        createvertexBufer()
    }
    
    // this is to create an array of vertices as now they are structs
    func createVertices() {
        vertices = [
            Vertex(position: SIMD3<Float>(0,1,0), color: SIMD4<Float>(1,0,0,1)),
            Vertex(position: SIMD3<Float>(-1,-1,0), color: SIMD4<Float>(0,1,0,1)),
            Vertex(position: SIMD3<Float>(1,-1,0), color: SIMD4<Float>(0,0,1,1))
        ]
    }
    
    // making the vertex buffer instance
    func createvertexBufer() {
        vertexBuffer = device?.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [] )
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
    
    // redraws the scence every 60 times a sec or based on your fps
    override func draw(_ dirtyRect: NSRect) {
        // before doing further operations checks if these vars are valid
        guard let drawwable = self.currentDrawable,
              let RenderPassDescriptor = self.currentRenderPassDescriptor
        else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: RenderPassDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(renderPipeLineState)
        
        renderCommandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawwable)
        commandBuffer?.commit()
        
    }
    
    
}
