$(document).ready(function() {
	$('.bookmark__form').on("submit", function(e) {
		e.preventDefault();

		const $form = $(this);
		const formData = $form.serialize();

		$.ajax({
			url: $form.attr("action"),
			type: "POST",
			data: formData,
			success: function(response) {
				const resultCode = response.resultCode;
				const $icon = $form.find(".bookmark__icon");

				if (resultCode.startsWith("S")) {
					$icon.addClass('bookmark__icon_col');
					showToast("북마크 추가됨");
				} else {
					$icon.removeClass('bookmark__icon_col');
					showToast("북마크 해제됨");
				}
				



			},
			error: function(xhr, status, error) {
				console.error("북마크 실패:", error);
				showToast("오류 발생");
			}
		});
	
	
		
	});

	function showToast(message) {
		const $toast = $(`<div class="toast-msg">${message}</div>`);
		$("body").append($toast);
		setTimeout(() => $toast.fadeOut(500, () => $toast.remove()), 1500);
	}
});


$(document).ready(function() {
	$('.img_uploard').on('submit', function(e) {
		e.preventDefault(); // 기본 폼 제출 막기

		let formData = new FormData(this);

		$.ajax({
			url: '/member/uploadProfile',
			type: 'POST',
			data: formData,
			contentType: false,
			processData: false,
			success: function(profileImage) {
				// 업로드 성공 시 처리
				alert('프로필 이미지 업로드 성공!');

				// 새 이미지로 교체
				// 서버에서 저장된 경로를 다시 가져와 사용하려면 JSON으로 처리하는 게 더 확실함
				// 지금은 단순하게 기존 이미지 새로고침 (캐시 방지용 query 추가)
				let timestamp = new Date().getTime();
				$('.img_upload img').attr('src', '/profile/' + profileImage + '?t=' + timestamp);
			},
			error: function() {
				alert('업로드 실패! 다시 시도해주세요.');
			}
		});
	});

	$.ajax({
		url: '/member/showImg',
		type: 'GET',
		success: function(res) {

			const resultCode = res.resultCode;
			
			  if (resultCode.startsWith("S")) {
			    const profileImage = res.data1;
			    let imageUrl = profileImage + '?t=' + new Date().getTime();
			    $('.img_reload img').attr('src', imageUrl);
			  } else {
			    console.error('이미지 경로가 없습니다:', res);
			  }
			},
		error: function() {
			console.error('프로필 이미지를 불러오지 못했습니다.');
		}
	});

});

let hideTimeout;

$('.img_reload').on('mouseenter', function () {
  clearTimeout(hideTimeout); // 사라짐 예약 취소
  $('.myP').addClass('myimgshow');
});

$('.myP').on('mouseenter', function () {
  clearTimeout(hideTimeout); // 사라짐 예약 취소
});

$('.img_reload, .myP').on('mouseleave', function () {
  hideTimeout = setTimeout(() => {
    $('.myP').removeClass('myimgshow');
  }, 300); // 300ms 뒤에 제거
});



// sse

/*
const userId = parseInt(document.body.dataset.userId, 10);

const eventSource = new EventSource(`/sse/connect/${userId}`);

eventSource.addEventListener("bookmark", function(event) {
	console.log("SSE 연결됨:", event.data);
	
    const data = JSON.parse(event.data);
    alert(data.message); // "홍길동님이 회원님의 글을 북마크 했습니다."
});

*/



const userId = document.body.dataset.userId;

if (userId) {
	const sse = new EventSource('/sse/connect/' + userId);

	// bookmark 이벤트 수신
	sse.addEventListener("bookmark", function(event) {
		let data;
		try {
			data = JSON.parse(event.data);
		} catch (e) {
			console.error("알림 데이터 파싱 오류:", e);
			return;
		}
		
		console.log("🔔 북마크 알림 수신:", data);
		const $container = $('#notification-box');
		
/*		
		const $container = $('.message');
		const html = 
		`
		<div>
			<a href="/usr/article/detail?articleId=${data.articleId}" class="hover:underline"> 알람이 도착했습니다! </a>
		</div>
		`	;
*/		
// 알림 박스에 새 항목 추가
const html = `
	<div class="notification-item">
		<a href="/usr/article/detail?articleId=${data.articleId}">
			${data.message || '새 알림이 도착했습니다'}
		</a>
	</div>
`;
		
		$container.prepend(html);
		
		$box.show(); // 알림창 표시
	});
} else {
	console.warn("SSE 연결 실패: 로그인한 사용자 ID가 없습니다.");
}


$('#notification-icon').on('click', function () {
	$('#notification-box').toggle();
});

