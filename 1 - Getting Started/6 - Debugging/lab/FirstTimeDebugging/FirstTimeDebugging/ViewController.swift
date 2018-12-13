import UIKit

class ViewController: UIViewController {

    override func viewDidLoad( {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var sample = "sample"
        print(sample)
        
        if false {
            print("Will this line of code ever be reached?")
            someMetho()
        }
        
        
    }
    
    func someMethod() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

