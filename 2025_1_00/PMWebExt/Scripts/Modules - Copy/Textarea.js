var self = {};
function Textarea() { self = this; }
Object.assign(Textarea.prototype, {
    constructor: Textarea,
    Init: function () {
        var kendoEditor = $(".CustomEditor");
        $.each(kendoEditor, function (i) {
            self.Render($(kendoEditor[i]).find("textarea"));
        })
        kendoEditor = $(".CustomEditorWithoutToolbar");
        $.each(kendoEditor, function (i) {
            self.Render($(kendoEditor[i]).find("textarea"));
            self.RemoveToolbar($(kendoEditor[i]));
        })

    },
    IncludeScript: function () {
        $('head').append('<link href="https://kendo.cdn.telerik.com/2019.3.1023/styles/kendo.default-v2.min.css" rel="stylesheet" />');
        var src = 'https:' === location.protocol ? 'https' : 'http',
            script = document.createElement('script');
        script.onload = self.Init;
        script.src = src +'://kendo.cdn.telerik.com/2019.3.1023/js/kendo.all.min.js';
        document.getElementsByTagName('body')[0].appendChild(script);
    },
    Render: function (textarea) {
        var editor = textarea.kendoEditor({
            encoded: false,
            pasteCleanup: {
                all: false,
                css: false,
                keepNewLines: false,
                msAllFormatting: false,
                msConvertLists: true,
                msTags: true,
                none: true,
                span: false
            },
            paste: function (e) {
                var html = $(e.html);
                var _htmlNew = '';
                $.each(html, function () {
                    var style = $(this).attr('style');
                    if (style && style.toLowerCase().indexOf('margin') >= 0) {
                        if ($(this).css('margin') && $(this).css('margin') != '') {
                            var margins = $(this).css('margin').split(' ');
                            for (var i = 0; i < margins.length; i++) {
                                if (margins[i].indexOf('pt') >= 0) {
                                    var val = parseFloat(margins[i].replace('pt', ''));
                                    if (val < 0) {
                                        margins[i] = '0pt';
                                    }
                                }
                                if (margins[i].indexOf('in') >= 0) {
                                    var val = parseFloat(margins[i].replace('in', ''));
                                    if (val < 0) {
                                        margins[i] = '0in';
                                    }
                                }
                            }
                            $(this).css('margin', margins.join(' '))
                        }
                    }
                    if (style && style.toLowerCase().indexOf('text-indent') >= 0 && $(this).tagName() == "P") {
                        if ($(this).css('text-indent') && $(this).css('text-indent') != '') {
                            var textIndent = $(this).css('text-indent');
                            if (textIndent.indexOf('pt') >= 0) {
                                var val = parseFloat(textIndent.replace('pt', ''));
                                if (val < 0) {
                                    $(this).css('text-indent', '0pt');
                                }
                            }
                            if (textIndent.indexOf('in') >= 0) {
                                var val = parseFloat(textIndent.replace('in', ''));
                                if (val < 0) {
                                    $(this).css('text-indent', '0in');
                                }
                            }
                        }
                    }
                    _htmlNew = _htmlNew + $(this).outerHTML();
                });
                e.html = _htmlNew;
            },
            tools: [
                "bold",
                "italic",
                "underline",
                "strikethrough",
                "justifyLeft",
                "justifyCenter",
                "justifyRight",
                "justifyFull",
                "insertUnorderedList",
                "insertOrderedList",
                "indent",
                "outdent",
                "createLink",
                "unlink",
                "insertImage",
                "insertFile",
                "subscript",
                "superscript",
                "tableWizard",
                "createTable",
                "addRowAbove",
                "addRowBelow",
                "addColumnLeft",
                "addColumnRight",
                "deleteRow",
                "deleteColumn",
                "mergeCellsHorizontally",
                "mergeCellsVertically",
                "splitCellHorizontally",
                "splitCellVertically",
                "viewHtml",
                "formatting",
                "cleanFormatting",
                "fontName",
                "fontSize",
                "foreColor",
                "backColor",
                "print"
            ]
        }).getKendoEditor();
    },
    RemoveToolbar: function (textarea) {
        $('.k-editor-toolbar', textarea).css({ "display": "none" });
    }
});
export { Textarea };