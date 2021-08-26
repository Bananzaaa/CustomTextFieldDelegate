//
//  CustomTextField.swift
//  CustomTextFieldDelegate
//
//  Created by Ацкий Станислав on 25.08.2021.
//

// Source: https://www.youtube.com/watch?v=FpNXqhtdVmI

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - Private
    
    private weak var _delegate: UITextFieldDelegate?
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        super.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        super.delegate = self
    }
    
    // MARK: - Override
    
    override var delegate: UITextFieldDelegate? {
        get {
            _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    // Чтобы не пришлось реализовывать все методы делегата текстфилда здесь, юзаем responds(to aSelector:), чтобы дать возможность для реализации нужных методов прямо во viewController. Проблема в том, что responds(to aSelector:) вернет true, если метод реализован в контроллере, далее система будет искать его во внутреннем делегате, и если он не реализован6 ловим краш (unrecognize selector). Для решения проблемы юзаем forwardingTarget(for aSelector:)
    
    // Если метод делегата реализован и внутри и снаружи, выполнится внутренняя реализация (в ней можем управлять проксированием)
     
    override func responds(to aSelector: Selector!) -> Bool {
        if let outterDelegate = _delegate,
           outterDelegate.responds(to: aSelector) {
            return true
        } else {
            return super.responds(to: aSelector)
        }
    }
    
    // Позволяет системе перенаправить вызов метода, если не будет найден во внутреннем делегате на внешний, если он там есть (вернет true), если же нет, вернет false (метод не найден)
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let outterDelegate = _delegate,
           outterDelegate.responds(to: aSelector) {
            return outterDelegate
        } else {
            return super.forwardingTarget(for: aSelector)
        }
    }
    
    // MARK: - Helpful
    
    private func someLogic() -> Bool {
        true
    }
}

extension CustomTextField: UITextFieldDelegate {
    
    // - Not proxy to outter delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        someLogic()
    }
    
    // - Proxy delegate to outter delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let outterDelegate = _delegate,
           outterDelegate.responds(to: #selector(textFieldDidBeginEditing(_:))) {
            outterDelegate.textFieldDidBeginEditing?(textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let outterDelegate = _delegate, outterDelegate.responds(to: #selector(textFieldDidEndEditing(_:))) {
            outterDelegate.textFieldDidEndEditing?(textField)
        }
    }
    
}
