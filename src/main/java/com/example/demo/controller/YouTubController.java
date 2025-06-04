package com.example.demo.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import org.springframework.ui.Model;

@Controller
@RequestMapping("/youtube")
public class YouTubController {

	private final String apiKey = "AIzaSyB1kZOuCJjjffXMAzbGZy5btsWfuKqE700";

	@GetMapping("/search")
    public String search(@RequestParam("q") String query, Model model) {
        String baseUrl = "https://www.googleapis.com/youtube/v3/search";
        String fullUri = baseUrl+            
        		"?part=snippet" +
                "&q="+ query+
                "&type=video" +
                "&maxResults=10" +
                "&order=relevance" +
                "&regionCode=KR" +
                "&relevanceLanguage=ko" +
                "&videoEmbeddable=true" + 
                "&key=" + apiKey;

        RestTemplate restTemplate = new RestTemplate();
        Map<String, Object> response = restTemplate.getForObject(fullUri, Map.class);

        List<Map<String, Object>> items = (List<Map<String, Object>>) response.get("items");
        model.addAttribute("videos", items); // JSP에 전달

        return "usr/youtube/result";
    }
}
