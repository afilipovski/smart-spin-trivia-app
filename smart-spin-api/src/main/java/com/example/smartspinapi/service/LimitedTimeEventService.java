package com.example.smartspinapi.service;

import com.example.smartspinapi.model.entity.LimitedTimeEvent;
import com.example.smartspinapi.repository.LimitedTimeEventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LimitedTimeEventService {
    private final LimitedTimeEventRepository limitedTimeEventRepository;

    public void save(LimitedTimeEvent limitedTimeEvent) {
        limitedTimeEventRepository.save(limitedTimeEvent);
    }
}
