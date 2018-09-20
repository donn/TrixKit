import Foundation

enum DSP {
    public static func discreteFourierTransform(samples: [Double]) -> (real: [Double], imaginary: [Double]) {
        var real = [Double]()
        var imaginary = [Double]()
        
        for (m, _) in samples.enumerated()
        {
            var realc: Double = 0
            var imaginaryc: Double = 0
            for (n, sample) in samples.enumerated()
            {
                realc += Double(sample) * cos((2 * Double.pi * Double(n) * Double(m)) / Double(samples.count))
                imaginaryc -= Double(sample) * sin((2 * Double.pi * Double(n) * Double(m)) / Double(samples.count))
            }
            real.append(Double(realc))
            imaginary.append(Double(imaginaryc))
        }
        
        return (real, imaginary)
    }
    
    public static func inverseDiscreteFourierTransform(real: [Double], imaginary: [Double]) -> (real: [Double], imaginary: [Double]) {
        var realTime = [Double]()
        var imaginaryTime = [Double]()
        
        for (n, _) in real.enumerated()
        {
            var realc: Double = 0
            var imaginaryc: Double = 0
            for (m, _) in imaginary.enumerated()
            {
                realc += Double(real[m]) * cos((2 * Double.pi * Double(n) * Double(m)) / Double(real.count))
                imaginaryc += Double(real[m]) * sin((2 * Double.pi * Double(n) * Double(m)) / Double(real.count))
                imaginaryc += Double(imaginary[m]) * cos((2 * Double.pi * Double(n) * Double(m)) / Double(imaginary.count))
                realc -= Double(imaginary[m]) * sin((2 * Double.pi * Double(n) * Double(m)) / Double(imaginary.count)) //j^2 == -1
            }
            realTime.append(Double(realc / Double(real.count)))
            imaginaryTime.append(Double(imaginaryc / Double(imaginary.count)))
        }
        
        return (realTime, imaginaryTime)
    }
    
    public static func fastFourierTransform(samples: [Double]) -> (real: [Double], imaginary: [Double]) {
        var real = [Double]()
        var imaginary = [Double]()
        
        for (m, _) in samples.enumerated()
        {
            var realc: Double = 0
            var imaginaryc: Double = 0
            
            var reald: Double = 0
            var imaginaryd: Double = 0
            
            let oddExtractCosine = cos((2 * Double.pi * Double(m)) / Double(samples.count))
            let oddExtractSine = -sin((2 * Double.pi * Double(m)) / Double(samples.count))
            
            for n in 0...(samples.count / 2 - 1)
            {
                let even = samples[n << 1]
                let odd = samples[(n << 1) + 1]
                let cosineComponent = cos((4 * Double.pi * Double(n) * Double(m)) / Double(samples.count))
                let sineComponent = -sin((4 * Double.pi * Double(n) * Double(m)) / Double(samples.count))
                
                realc += Double(even) * cosineComponent
                imaginaryc += Double(even) * sineComponent
                
                reald += Double(odd) * cosineComponent
                imaginaryd += Double(odd) * sineComponent
            }
            
            real.append(Double(realc + (reald * oddExtractCosine) - (imaginaryd * oddExtractSine)))
            imaginary.append(Double(imaginaryc + (reald * oddExtractSine) + (imaginaryd * oddExtractCosine)))
        }
        
        return (real, imaginary)
    }
    
    //Duplication rationale: branch for windowing would otherwise affect timing of FFT, comparison would become unfair
    public static func windowedFastFourierTransform(samples: [Double], with window: (_ n: Int, _ N: Int) -> Double) -> (real: [Double], imaginary: [Double]) {
        var real = [Double]()
        var imaginary = [Double]()
        
        for (m, _) in samples.enumerated()
        {
            var realc: Double = 0
            var imaginaryc: Double = 0
            
            var reald: Double = 0
            var imaginaryd: Double = 0
            
            let oddExtractCosine = cos((2 * Double.pi * Double(m)) / Double(samples.count))
            let oddExtractSine = -sin((2 * Double.pi * Double(m)) / Double(samples.count))
            
            for n in 0...(samples.count / 2 - 1)
            {
                let even = samples[n << 1]
                let odd = samples[(n << 1) + 1]
                let cosineComponent = cos((4 * Double.pi * Double(n) * Double(m)) / Double(samples.count))
                let sineComponent = -sin((4 * Double.pi * Double(n) * Double(m)) / Double(samples.count))
                
                realc += Double(even) * cosineComponent * window(n, samples.count)
                imaginaryc += Double(even) * sineComponent * window(n, samples.count)
                
                reald += Double(odd) * cosineComponent * window(n + 1, samples.count)
                imaginaryd += Double(odd) * sineComponent * window(n + 1, samples.count)
            }
            
            real.append(Double(realc + (reald * oddExtractCosine) - (imaginaryd * oddExtractSine)))
            imaginary.append(Double(imaginaryc + (reald * oddExtractSine) + (imaginaryd * oddExtractCosine)))
        }
        
        return (real, imaginary)
    }
    
    public static func polarize(real: [Double], imaginary: [Double]) -> (magnitude: [Double], phase: [Double]) {
        var magnitude = [Double]()
        var phase = [Double]()
        for i in 0..<(real.count)
        {
            magnitude.append(Double(sqrt(pow(Double(real[i]), 2) + pow(Double(imaginary[i]), 2))))
            phase.append(Double(atan(Double(imaginary[i]) / Double(real[i])) * 180 / Double.pi))
        }
        
        return (magnitude, phase)
    }
}
