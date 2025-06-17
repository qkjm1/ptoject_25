package com.example.demo;

import java.util.concurrent.TimeUnit;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/static/**") // 정적 리소스 URL
//                .addResourceLocations("classpath:/static/") // 정적리소스의 실제 경로
//                .setCacheControl(CacheControl.maxAge(365, TimeUnit.DAYS)); // 1년 캐시 (몇년짜리 캐시할건지!!!)
        
    	registry.addResourceHandler("/models/**")
        .addResourceLocations("classpath:/static/models/")
        .setCacheControl(CacheControl.maxAge(365, TimeUnit.DAYS));
        
    }
}
