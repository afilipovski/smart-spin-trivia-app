package com.example.smartspinapi.resolvers;

import com.example.smartspinapi.model.entity.UserProfile;
import com.example.smartspinapi.model.exception.UserProfileNotFoundException;
import com.example.smartspinapi.repository.UserProfileRepository;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

@Component
@RequiredArgsConstructor
public class TriviaUserArgumentResolver implements HandlerMethodArgumentResolver {
    private final UserProfileRepository userProfileRepository;

    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.getParameterAnnotation(TriviaUser.class) != null &&
                parameter.getParameterType().equals(UserProfile.class);
    }

    @Override
    public Object resolveArgument(@NonNull MethodParameter parameter,
                                  ModelAndViewContainer mavContainer,
                                  NativeWebRequest webRequest,
                                  WebDataBinderFactory binderFactory) {
        String uid = (String) webRequest.getAttribute("uid", RequestAttributes.SCOPE_REQUEST);

        return userProfileRepository.getUserProfileById(uid)
                .orElseThrow(() -> new UserProfileNotFoundException(uid));
    }
}
