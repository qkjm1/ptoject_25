package com.example.demo.vo;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class YouTube {

	private List<Item> items;

	@Data
    @AllArgsConstructor
    @NoArgsConstructor
	public static class Item {
		private Id id;
		private Snippet snippet;
	}

	@Data
    @AllArgsConstructor
    @NoArgsConstructor
	public static class Id {
		private String videoId;
	}
	
	@Data
    @AllArgsConstructor
    @NoArgsConstructor
	public static class Snippet {
		private String title;
		private String description;
		private Thumbnails thumbnails;
	}
	
	@Data
    @AllArgsConstructor
    @NoArgsConstructor
	public static class Thumbnails {
		private Thumbnail medium;
	}
	
	@Data
    @AllArgsConstructor
    @NoArgsConstructor
	public static class Thumbnail {
		private String url;
	}


}
