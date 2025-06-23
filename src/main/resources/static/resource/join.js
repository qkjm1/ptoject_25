let debounceTimer;

  $("#loginId").on("input", function () {
    const loginId = $(this).val().trim();

    clearTimeout(debounceTimer);

    // debounce: 300ms 대기 후 실행
    debounceTimer = setTimeout(() => {
      if (loginId.length < 3) {
        $("#usernameCheckMessage").text("아이디는 최소 5자 이상이어야 합니다.").css("color", "gray");
        return;
      }

      $.ajax({
        url: "/usr/member/checkUsername",
        method: "GET",
        data: { loginId: loginId },
        success: function (response) {
          if (response.data1) {
            $("#usernameCheckMessage").text("✅ 사용 가능한 아이디입니다.").css("color", "green");
          } else {
            $("#usernameCheckMessage").text("❌ 이미 사용 중인 아이디입니다.").css("color", "red");
          }
        },
        error: function () {
          $("#usernameCheckMessage").text("서버 오류가 발생했습니다.").css("color", "orange");
        }
      });
    }, 300); // 입력 후 300ms 대기
  });