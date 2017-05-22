//
//  ViewController.swift
//  BEMCheckBox
//
//  Created by Trong Tran on 3/19/17.
//  Copyright © 2017 Trong Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BEMCheckBoxDelegate {

    @IBOutlet var arrTestingAnimation: [BEMCheckBox]!
    
    var groupAnimation:BEMCheckBoxGroup!
    
    
    @IBOutlet weak var smBoxType: UISegmentedControl!
    
    @IBOutlet weak var lblAnimation: UILabel!
    
    @IBOutlet weak var sliAnimation: UISlider!
    
    @IBOutlet weak var lblLineWidth: UILabel!
    
    @IBOutlet weak var sliLineWidth: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //Set check box's on/off state
        self.testingCheckBox.setOn(true, animated: true)
        */
        
        /*
        //Check selected check box in group
        let selection = groupAnimation.selectedCheckBox
        print("Check box \((selection?.tag)!) is selected")
        */
        
        //Set up group
        groupAnimation = BEMCheckBoxGroup(checkBoxes: arrTestingAnimation)
        groupAnimation.mustHaveSelection = true
        groupAnimation.selectedCheckBox = arrTestingAnimation[0]
        for checkBox in arrTestingAnimation{
            //Set up delegate
            checkBox.delegate = self
            //Set up animation
            switch checkBox.tag {
            case 3:
                checkBox.onAnimationType = .fill
                checkBox.offAnimationType = .fill
            case 4:
                checkBox.onAnimationType = .bounce
                checkBox.offAnimationType = .bounce
            case 5:
                checkBox.onAnimationType = .flat
                checkBox.offAnimationType = .flat
            case 6:
                checkBox.onAnimationType = .fade
                checkBox.offAnimationType = .fade
            case 7:
                checkBox.onAnimationType = .stroke
                checkBox.offAnimationType = .stroke
            case 8:
                checkBox.onAnimationType = .oneStroke
                checkBox.offAnimationType = .oneStroke
            default: break
            }
        }
    }
    
    func loopAllCheckBoxDo(completionHandler:(BEMCheckBox) -> ()){
        for checkBox in arrTestingAnimation {
            completionHandler(checkBox)
        }
    }
    
    //Set up box type (square type must have corner radius, about 2)
    @IBAction func changeBoxType(_ sender: Any) {
        if (smBoxType.selectedSegmentIndex == 0){
            loopAllCheckBoxDo(completionHandler: { (cb) in
                cb.boxType = .circle
            })
        } else {
            loopAllCheckBoxDo(completionHandler: { (cb) in
                cb.boxType = .square
            })
        }
    }
    
    @IBAction func changeAnimationDuration(_ sender: Any) {
        let value = sliAnimation.value
        loopAllCheckBoxDo(completionHandler: { (cb) in
            cb.animationDuration = CGFloat(value)
        })
        lblAnimation.text = "Animation duration (\(value)):"
    }
    
    @IBAction func changeLineWidth(_ sender: Any) {
        let value = sliLineWidth.value
        loopAllCheckBoxDo(completionHandler: { (cb) in
            cb.lineWidth = CGFloat(value)
        })
        lblLineWidth.text = "Line width (\(value)):"
    }
    
    
    //Sent to the delegate every time the check box gets tapped, after its properties are updated (on), but before the animations are completed.
    func didTap(_ checkBox: BEMCheckBox) {
        print("Check box \(checkBox.tag) is selected")
    }
    
    //Sent to the delegate every time the check box finishes being animated.
    func animationDidStop(for checkBox: BEMCheckBox) {
        print("Check box \(checkBox.tag)'s animation is stopped")
    }

}

