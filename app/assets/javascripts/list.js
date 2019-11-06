// TODO できたらsubmitなしでリスト登録する
$(function() {
    $(".radio-label",).on("click", function() {
        $(this).children($('input[name="list[status]"]')).prop("checked", "checed");
        $(".edit_list").submit();
        $("#new_list").submit();
    });
    var radio_checed = $('input[name="list[status]"]:checked');
    if ($(radio_checed).val() == 0 ||
        $(radio_checed).val() == 1 ||
        $(radio_checed).val() == 2) {
        $('input[name="list[status]"]:checked').parent().css("background-color", "#FFCC33");
    }
});
