package com.example.smartspinapi.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HealthcheckController {
    @GetMapping("/health")
    public String healthcheck() {
        return "healthy";
    }
}
