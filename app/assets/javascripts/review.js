$(function() {
    // $('input[name="today"]').change(function(){
    $('input[name="today"]').on("click", function(){
        var date_select = $(this).parent().prev($(".today"))
        var first_select = $(date_select).children()[2]
        var second_select = $(date_select).children()[3]
        var third_select = $(date_select).children()[4]

        var now = new Date();
        var now_year = now.getFullYear();
        var now_month = now.getMonth() + 1;
        var now_day = now.getDate();

        $(first_select).val(now_year);
        $(second_select).val(now_month);
        $(third_select).val(now_day);
    });
});
