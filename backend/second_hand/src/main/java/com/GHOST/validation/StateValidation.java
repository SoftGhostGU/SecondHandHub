package com.GHOST.validation;

import com.GHOST.anno.State;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class StateValidation implements ConstraintValidator<State, String> {

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null) {
            return true;
        } else if (value.equals("未被购买") || value.equals("已被购买")) {
            return true;
        } else {
            return false;
        }
    }
}
