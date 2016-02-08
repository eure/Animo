Pod::Spec.new do |s|
    s.name = "Animo"
    s.version = "1.1.0"
    s.license = "MIT"
    s.summary = "Bring life to CALayers with SpriteKit-like animation builders."
    s.homepage = "https://github.com/eure/Animo"
    s.author = { "John Rommel Estropia" => "john.estropia@eure.jp" }
    s.source = { :git => "https://github.com/eure/Animo.git", :tag => s.version.to_s }
    
    s.ios.deployment_target = "8.0"
    s.osx.deployment_target = "10.10"
    s.watchos.deployment_target = "2.0"
    s.tvos.deployment_target = "9.0"
    
    s.source_files = "Animo", "Animo/**/*.{swift}"
    s.frameworks = "Foundation", "UIKit", "QuartzCore"
    s.requires_arc = true
end
