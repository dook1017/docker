package com.dook.example.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by Administrator on 2020/4/27 0027.
 */

@RestController
@RequestMapping("/dook")
public class Test {


    /**
     * test
     */
    @RequestMapping("/test")
    public String test() {
        return "hello world";
    }

}


