package com.GHOST;

import org.junit.jupiter.api.Test;

public class ThreadLocalTest {

    @Test
    public void testThreadLocalSetAndGet() {
        ThreadLocal tl = new ThreadLocal<>();

        new Thread(() -> {
            tl.set("ThreadLocal-1 Value");
            System.out.println(Thread.currentThread().getName() + " : " + tl.get());
            System.out.println(Thread.currentThread().getName() + " : " + tl.get());
            System.out.println(Thread.currentThread().getName() + " : " + tl.get());
        }, "Thread-1").start();

        new Thread(() -> {
            tl.set("ThreadLocal-2 Value");
            System.out.println(Thread.currentThread().getName() + " : " + tl.get());
            System.out.println(Thread.currentThread().getName() + " : " + tl.get());
            System.out.println(Thread.currentThread().getName() + " : " + tl.get());
        }, "Thread-2").start();
    }
}
