Pod::Spec.new do |s|
    s.name = "Animo"
    s.version = "1.0.0"
    s.license = "MIT"
    s.summary = "Bring life to CALayers with SpriteKit-like animation builders."
    s.homepage = "https://github.com/JohnEstropia/Animo"
    s.author = { "John Rommel Estropia" => "rommel.estropia@gmail.com" }
    s.source = { :git => "https://github.com/JohnEstropia/Animo.git", :tag => s.version.to_s }
    
    s.ios.deployment_target = "8.0"
    
    s.source_files = "Animo", "Animo/**/*.{swift}"
    s.frameworks = "Foundation", "UIKit", "QuartzCore"
    s.requires_arc = true
end
