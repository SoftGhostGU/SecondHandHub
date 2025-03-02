package com.GHOST.anno;

import com.GHOST.validation.StateValidation;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.constraints.NotEmpty;

import java.lang.annotation.Documented;
import java.lang.annotation.Repeatable;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.ElementType.TYPE_USE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Documented
@Constraint(validatedBy = {StateValidation.class})
@Target({ FIELD })
@Retention(RUNTIME)
public @interface State {

    String message() default "state参数的值只能是[未被购买]或者[已被购买]";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
