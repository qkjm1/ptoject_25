package com.example.demo.sse;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.apache.catalina.connector.ClientAbortException;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.example.demo.util.Ut;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SseEmitters {
			// 주로 공지사항, 시스템 메세지, 전원에게 전파해야하는 이벤트에 사용됨
//    private final List<SseEmitter> emitters = new CopyOnWriteArrayList<>();

	// 지정된 사람한테만 이벤트 전송
	private final Map<Long, SseEmitter> emitters = new ConcurrentHashMap<>();
	
    public SseEmitter add(Long userId, SseEmitter emitter) {
        this.emitters.put(userId, emitter);
        System.out.println("-----------------2");
        emitter.onCompletion(() -> {
            this.emitters.remove(userId); // this를 써주는게 더 명확 삭제는 유저아이디를 기준으로
        });
        
        emitter.onTimeout(() -> {
            emitter.complete();
        });

        System.out.println("--------- emitter--------3"+ emitter);
        
        return emitter;
    }

    public void noti(Long userId, String eventName) {
        noti(userId, eventName, Ut.mapOf());
    }

    public void noti(Long userId, String eventName, Map<String, Object> data) {
//        emitters.forEach(emitter -> {// 전체이용자에게 이벤트를 발송하는 로직
//            try {
//                emitter.send(
//                        SseEmitter.event()
//                                .name(eventName)
//                                .data(data)
//                );
//            }catch (ClientAbortException e) {
//                // 연결 끊긴 클라이언트
//            } catch (IOException e) {
//                throw new RuntimeException(e);
//            }
//        });
    	System.out.println("-----------------1");
    	SseEmitter emitter = emitters.get(userId); // 지정된 이용자를 찾고
    	
    	if (emitter != null) {
            try {
            	
                emitter.send(
                		SseEmitter.event()
                		.name(eventName)
                		.data(data));
            } catch (IOException e) {
                emitters.remove(userId); // 실패한 연결 제거
            }
        }
    	
    }
}