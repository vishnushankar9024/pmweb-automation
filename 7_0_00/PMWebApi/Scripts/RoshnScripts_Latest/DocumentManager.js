var documentManager = {
    init: function () {
        documentManager.bindEvent();
    },
    bindEvent: function () {
        var container = $('#rdgAttributes_GridData');
        if (container && container.length > 0) {
            $('input[type="text"]', container).each(function () {
                $(this).bind('paste', documentManager.onPaste);
            })
        }
    },
    onPaste: function (e) {
        var $start = $(this);
        var idx = $('td', $start.closest('tr')).index($start.closest('td'));
        var data = documentManager.getClipboardData(e);
        if (data.length > 0) {
            var rows = data.split("\n");
            $.each(rows, function () {
                var values = this.split("\t");
                $.each(values, function () {
                    $start.val(this);
                    if ($start.closest('td').next('td').find('input[type="text"]')[0] != undefined) {
                        $start = $start.closest('td').next('td').find('input[type="text"]');
                    }
                    else {
                        return false;
                    }
                });
                $start = $start.closest('td').parent().next('tr').children('td:eq(' + idx + ')').find('input[type="text"]');
            });
            e.preventDefault();
        }
    },
    getClipboardData: function (e) {
        var source

        if (window.clipboardData !== undefined) {
            source = window.clipboardData
        } else {
            source = e.originalEvent.clipboardData;
        }
        return source.getData("Text");
    }
}

$(document).ready(documentManager.init);