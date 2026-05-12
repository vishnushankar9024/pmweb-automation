var self = {}, ext = {};
function Textarea(_ext) {
    self = this;
    ext = _ext;
}
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
        var memos = $("textarea[name$='txtMemo']");
        $.each(memos, function (i) {
            var textarea = $(memos[i]);
            self.Render(textarea);
            self.RemoveToolbar(textarea, true);
            self.SetHeight(textarea, '70px !important');
        })

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
    RemoveToolbar: function (textarea, isparent) {
        // $('.k-editor-toolbar-wrap', isparent ? textarea.parent().parent().parent() : textarea).css({ "display": "none" });
        $('.k-editor-toolbar-wrap', isparent ? textarea.parent().parent().parent() : textarea).remove();
    },
    SetHeight: function (textarea, height) {
        $('iframe', textarea.parent()).attr("style", "height: " + height);
    }
});
export { Textarea };