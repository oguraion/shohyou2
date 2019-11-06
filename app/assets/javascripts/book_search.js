$(function() {
    $('select[name=sort_order]').change(function() {

        var this_value = $(this).val();
        // 選択したプルダウンによるページ遷移先の分岐
        if (this_value == "1") {
            html = "&sort=1"
        } else if (this_value == "2") {
            html = "&sort=2"
        } else if (this_value == "3") {
            html = "&sort=3"
        } else if (this_value == "4") {
            html = "&sort=4"
        } else {
            html = ""
        };
        var current_html = window.location.href;
        if (location['href'].match(/&sort=*.+/) != null) {
            var remove = "?" + location['href'].match(/&sort=*.+/)[0]
            var current_html = current_html.replace(remove, '')
        };

        window.location.href = current_html + "?" +html
    });
    if (location['href'].match(/&sort=*.+/) != null) {
    // option[selected: 'selected']を削除
        if ($('select option[selected=selected]')) {
            $('select option:first').prop('selected', false);
        }

        var selected_option = location['href'].match(/&sort=*.+/)[0].replace('&sort=', '');
        console.log(selected_option)

        if(selected_option == "1") {
            var sort = 1
        } else if (selected_option == "2") {
            var sort = 2
        } else if (selected_option == "3") {
            var sort = 3
        } else if (selected_option == "4") {
            var sort = 4
        }
        var add_selected = $('select[name=sort_order]').children()[sort]
        $(add_selected).attr('selected', true)
    };
});
