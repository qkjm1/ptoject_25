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
public class Board {

	private int id;
	private String name;
	private String code;
	
	private boolean delStatus;
	private LocalDateTime delDate;


}
