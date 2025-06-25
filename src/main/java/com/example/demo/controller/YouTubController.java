package com.example.demo.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
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
	@ResponseBody
	public Map<String, Object> search(@RequestParam("q") String query, @RequestParam(value = "pageToken", required = false) String pageToken) {
	    String baseUrl = "https://www.googleapis.com/youtube/v3/search";
	    StringBuilder fullUri = new StringBuilder(baseUrl)
	            .append("?part=snippet")
	            .append("&q=").append(query)
	            .append("&type=video")
	            .append("&maxResults=3")
	            .append("&order=relevance")
	            .append("&regionCode=KR")
	            .append("&relevanceLanguage=ko")
	            .append("&videoEmbeddable=true")
	            .append("&key=").append(apiKey);
	    
	    
	    
	    if (pageToken != null && !pageToken.isEmpty()) {
	        fullUri.append("&pageToken=").append(pageToken);
	    }

	    RestTemplate restTemplate = new RestTemplate();
	    Map<String, Object> response = restTemplate.getForObject(fullUri.toString(), Map.class);

	    Map<String, Object> result = new HashMap<>();
	    result.put("videos", response.get("items"));
	    result.put("nextPageToken", response.get("nextPageToken"));
	    
	    return result;
	}

}