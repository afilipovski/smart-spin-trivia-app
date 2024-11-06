package com.example.smartspinapi.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthcheckController {
    @GetMapping("/health")
    public String healthcheck(@RequestAttribute String uid) {
        return "Server healthy, uid " + uid;
    }
}
