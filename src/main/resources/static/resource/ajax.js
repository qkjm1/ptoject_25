$(document).ready(function () {
  $('.bookmark__form').on("submit", function (e) {
    e.preventDefault();

    const $form = $(this);
    const formData = $form.serialize();

    $.ajax({
      url: $form.attr("action"),
      type: "POST",
      data: formData,
      success: function (response) {
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
      error: function (xhr, status, error) {
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