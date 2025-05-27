package com.example.demo.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Info {

	private int id;
	private String part;
	private String body;
	
	private boolean delStatus;
	private LocalDateTime delDate;

}
