import MetalKit
class Renderer: NSObject{

    //each game object nees to be a node- need to create data structure where we can store many game objects that do not contain a mesh - not describe the node/position aspect of it - just mehs ( shape of object)
    var player = Player()//can create 2 gametypes of2 different shapes - even calling game object is wierd
}
extension Renderer: MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //used when the window is resized
        //helpful when use matrices to change aspect ratio
    }
    //in the NSView, part of MTKView-
    func draw(in view: MTKView){
        //once tries to get current drawable- willl continue on
        guard let drawable = view.currentDrawable else { return}
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return}
        //need to make a coomand buffer -whatever order enque command buffer in queue - will execute first
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        //render commadn encoder- tell commadn buffer what ot do when it is called
        //- can render graphics directly to screen
        // compute command encoder -computation tasks, mathematics- things wiant to multithread over GPU,
        //blit command encoder- memory managment
    // paralel command: able to render mutliple things at the same time - if want to render tecture and then turn into another tecture0 write two textures to the screeen.
        //use renderpass descriptor to instantiate comand encoder- renderpassdescriptor -has pixel/ buffer store infor ofr next job
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        //set render command encoder render pipeline state
        //most important thing:
        //holds a lot of info - vertex function, fragment functions, color attachment
        //color attachment - pixel format: colorattachement[0] must match MSView(GameVIew)- need to set to .bgra8Unorm
        //vertex and fragment made with MTL library - it makes these fucntions, then stores in pipline descripton, vertex and fragment live in metal file
        player.render(renderCommandEncoder: renderCommandEncoder!)
        //need to stop render command encoder:
        renderCommandEncoder?.endEncoding()
        //need to present next drawable to screen
        commandBuffer?.present(drawable)
        //now commit it to the next buffer
        commandBuffer?.commit()
        
        //rendering using GPU in swift and metal - compile data on cpu, ship to gpu, then pop out of gpu, and put on nsview
        /*
         what are MTL buffers?
         unforamted device accessible space:
            If take n obytes ( off in memory and want to put stuff into it )- want 12 byes of memory that we can grab from and have areference to it
            want to allocate 12 bytes worth of space ( nothing written there, jsut for outr access)
            when create buffer, always the same amoutn - buffered - bc know the amount of data that the reference will have - if write more or less, it will voerwrite the buffer
            then we can store our data in it - have 12 bytes of buffer ( cna grab as we have reference to it)
         now we can use cpu and gpu to read and write to that area
         in our case, a triangle
         
         How to make a triangle?
            scren spce coordinates- have origin at 0,0,0 ( in the middle of the screen)
            - point out of nose and come behind you ( z- component)
            min and max = -1,1 - only goes in unit space
            want to create vertex array that will store tiangle angle- need 3 float 3
            vertexArray: [float3]=[flaot3(0,1,0), float3(-1,-1,0). float3(1,-1,0)]
            wil draw and last one will connect to the first as we are using a triangle primitive type
        How to compile data in vertex buffer?
            have 3 float 3's - need to store that info- vert array size = 16 byes *3 = 48 bytes size ( the size of the buffer) - 16 bytes bc a float 3 holds 16 bytes
        Device space:
            have rows of unoformated buffer memory - index with allocated space and data - does not even exist rn - can have a max of 30 buffered memory - not need to use that much-
            use the device to make a buffer:
            vertexBuffer =Device.MakeBuffer(bytes: VertexArray, size: 48 BYtes, index: 0)
            size: 48 bytes
            index = 0
            bytes: vertetx array
            
            how use with GPU - create the buffer, but not actually set it - use the vertex shader to draw with these vertecies - first parament to vertex shader is at buffer index 0 - ties to index of the device space- when use render command encoder to setr at vindex 0, use the attriburte to grab at index 0- can grab it out of the device space using buffer attribute tag ( index)
         
         vertex float4 basic_vertex_shader(device flaot3 *vertices [[buffer(0) ]], uint vertexID [[vertex_id}})[
         return vertices[vertexID};
         }
         gpu will return position to rasterizer
         
         
         
         
         */
    }
}
