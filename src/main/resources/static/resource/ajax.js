$(document).ready(function() {
	$("#bookmark__btn").on("submit", function(e) {
		e.preventDefault();

		const $form = $(this);
		const formData = $form.serialize();

		$.ajax({
			url: $form.attr("action"),
			type: "POST",
			data: formData,
			success: function(response) {
				const resultCode = response.resultCode;
				console.log(response);

				if (resultCode.startsWith("S")) {
					$("#bookmark__icon").addClass('bookmark__icon_col');
				} else {
					$("#bookmark__icon").removeClass('bookmark__icon_col');
				}
			},
			error: function(xhr, status, error) {
				console.error("즐겨찾기 실패:", error);
			}
		});
	});
});